require './lib/gocd_pre_push/build_informer'
require './lib/gocd_pre_push/build_officer'

describe 'BuildOffice' do
  context 'investigate' do
    it 'should return true when any of the pipelines is red' do
      pipelines = instance_double('pipeline', name: 'MyPipeline :: my_stage')
      build_informer = instance_double('build_informer', information_available?: true, red_pipelines: [pipelines])

      expect(GOCD_PRE_PUSH::BuildInformer).to receive(:new).and_return(build_informer)
      officer = GOCD_PRE_PUSH::BuildOfficer.new 'concerned_pipelines', 'server_details'

      expect(officer.investigate).to be_truthy
    end

    it 'should return false when all pipelines are green' do
      build_informer = instance_double('build_informer', information_available?: true, red_pipelines: [])

      expect(GOCD_PRE_PUSH::BuildInformer).to receive(:new).and_return(build_informer)
      officer = GOCD_PRE_PUSH::BuildOfficer.new 'concerned_pipelines', 'server_details'

      expect(officer.investigate).to be_falsey
    end

    it 'should return true when information is not available' do
      build_informer = instance_double('build_informer', information_available?: false)

      expect(GOCD_PRE_PUSH::BuildInformer).to receive(:new).and_return(build_informer)
      officer = GOCD_PRE_PUSH::BuildOfficer.new 'concerned_pipelines', 'server_details'

      expect(officer.investigate).to be_truthy
    end
  end
end