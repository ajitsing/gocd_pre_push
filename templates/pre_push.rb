def pre_push_hook
  <<-HOOK
#!/usr/bin/env ruby

require 'gocd_pre_push'

include GOCD_PRE_PUSH
include GOCD_PRE_PUSH::PrettyPrinter

gocd_server = GocdServer.with do |server|
  server.url = 'http://yourgocdserverurl.com'
  server.username = 'your_gocd_username'
  server.password = 'your_gocd_password'
end

#Don't change the pipelines path unless gocd_pre_push.yml is not present in the repo's root folder
crime_found = BuildOfficer.new('gocd_pre_push.yml', gocd_server).investigate

abort if crime_found
  HOOK
end