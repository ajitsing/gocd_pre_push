require_relative 'build_informer'
require_relative 'pretty_printer'

module GOCD_PRE_PUSH
  class BuildOfficer
    include GOCD_PRE_PUSH::PrettyPrinter

    def initialize(concerned_pipelines, server_details)
      @build_informer = BuildInformer.new concerned_pipelines, server_details
    end

    def investigate
      print_info "Build cop is on duty.."
      red_pipelines = @build_informer.red_pipelines

      if red_pipelines.any?
        report_red_builds(red_pipelines)
      else
        print_success 'All clear!'
      end

      red_pipelines.any?
    end

    private
    def report_red_builds(pipelines)
      print_info "The cop found below crimes, all will be judged..\n"
      pipelines.each_with_index do |pipeline, index|
        pipeline, stage = pipeline.name.gsub(' ', '').split('::')
        print_error "  #{index+1}. #{pipeline}'s #{stage} stage is failing.\n"
      end
    end
  end
end
