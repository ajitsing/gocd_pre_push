require_relative 'build_informer'

module GOCD_PRE_PUSH
  class BuildOfficer
    def initialize(concerned_pipelines, server_details)
      @build_informer = BuildInformer.new concerned_pipelines, server_details
    end

    def investigate
      print "Checking pipelines build statuses...\n"

      if @build_informer.information_available?
        red_pipelines = @build_informer.red_pipelines
        report_red_builds red_pipelines
        suspects_found = red_pipelines.any?
      else
        print "Could not fetch pipeline statuses!!\n"
        suspects_found = true
      end

      suspects_found
    end

    private
    def report_red_builds(pipelines)
      pipelines.each do |pipeline|
        pipeline, stage = pipeline.name.gsub(' ', '').split('::')
        print "#{pipeline}'s #{stage} stage is failing.\n"
      end
    end
  end
end
