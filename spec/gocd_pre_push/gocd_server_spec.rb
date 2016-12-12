require './lib/gocd_pre_push/gocd_server'

describe 'GocdServer' do
  context 'initialize' do
    it 'should initialize the gocd server with url, username and password' do
      gocd_server = GOCD_PRE_PUSH::GocdServer.with do |server|
        server.url = 'http://serverurl.com'
        server.username = 'myusername'
        server.password = 'pass'
      end

      expect(gocd_server.url).to eq('http://serverurl.com')
      expect(gocd_server.username).to eq('myusername')
      expect(gocd_server.password).to eq('pass')
    end
  end
end