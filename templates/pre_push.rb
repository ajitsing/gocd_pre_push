def pre_push_hook
  <<-HOOK
#!/usr/bin/env ruby

require 'gocd_pre_push'

include GOCD_PRE_PUSH

#Add your gocd server details here
gocd_server = GocdServer.with do |server|
  server.url = 'http://yourgocdserverurl.com'
  server.username = 'your_gocd_username'
  server.password = 'your_gocd_password'
end

#Don't change the pipelines path unless pipelines.yml is not present in the repo's root folder
suspects_found = BuildOfficer.new('pipelines.yml', gocd_server).investigate

if suspects_found
  abort 'Can not push!'
else
  print 'All dependent pipelines are green! You can push your changes :)'
end
  HOOK
end