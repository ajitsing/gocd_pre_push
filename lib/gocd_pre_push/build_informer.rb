require 'gocd'
require 'yaml'

module GOCD_PRE_PUSH
  class BuildInformer
    attr_reader :pipelines

    def initialize(pipelines, gocd_server)
      GOCD.server = GOCD::Server.new gocd_server.url
      GOCD.credentials = GOCD::Credentials.new gocd_server.username, gocd_server.password

      pipelines = YAML::load_file pipelines
      pipelines.map! { |pipeline| pipeline_stage_name pipeline }.flatten!
      @pipelines = GOCD::PipelineGroup.new(pipelines, cache: true)
    end

    def information_available?
      @pipelines.information_available?
    end

    def red_pipelines
      @pipelines.red_pipelines
    end

    def any_red?
      @pipelines.any_red?
    end

    private
    def pipeline_stage_name(pipeline)
      pipeline['stages'].map { |s| "#{pipeline['pipeline']} :: #{s}" }
    end
  end
end