require './lib/gocd_pre_push/gocd_server'
require './lib/gocd_pre_push/build_informer'

describe 'BuildInformer' do
  gocd_server = GOCD_PRE_PUSH::GocdServer.with do |server|
    server.url = 'http://yourgocdserverurl.com'
    server.username = 'your_gocd_username'
    server.password = 'your_gocd_password'
  end

  context '#pipelines' do
    it 'should create a group of pipelines from given yml file' do
      pipelines = ['MyAwesomeProject :: spec', 'MyAwesomeProject :: integration', 'MyAwesomeProject :: generate_artifacts', 'MyAwesomeProject_Smoke :: smoke']
      expect(GOCD::PipelineGroup).to receive(:new).with(pipelines, {cache: true})

      GOCD_PRE_PUSH::BuildInformer.new './spec/gocd_pre_push/pipelines.yml', gocd_server
    end

    it 'should return the pipelines group' do
      build_informer = GOCD_PRE_PUSH::BuildInformer.new './spec/gocd_pre_push/pipelines.yml', gocd_server

      expect(build_informer.pipelines.is_a?(GOCD::PipelineGroup)).to be_truthy
    end
  end

  it 'should tell if information is available' do
    pipelines_group = instance_double('PipelineGroup', information_available?: 'true')

    expect(GOCD::PipelineGroup).to receive(:new).and_return(pipelines_group)
    build_informer = GOCD_PRE_PUSH::BuildInformer.new './spec/gocd_pre_push/pipelines.yml', gocd_server

    expect(build_informer.information_available?).to be_truthy
  end

  it 'should return the red pipelines' do
    pipelines_group = instance_double('PipelineGroup', red_pipelines: 'red_pipelines')

    expect(GOCD::PipelineGroup).to receive(:new).and_return(pipelines_group)
    build_informer = GOCD_PRE_PUSH::BuildInformer.new './spec/gocd_pre_push/pipelines.yml', gocd_server

    expect(build_informer.red_pipelines).to eq('red_pipelines')
  end

  it 'should return when any of the pipelines is red' do
    pipelines_group = instance_double('PipelineGroup', any_red?: true)

    expect(GOCD::PipelineGroup).to receive(:new).and_return(pipelines_group)
    build_informer = GOCD_PRE_PUSH::BuildInformer.new './spec/gocd_pre_push/pipelines.yml', gocd_server

    expect(build_informer.any_red?).to be_truthy
  end
end