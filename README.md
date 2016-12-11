# gocd_pre_push
Check GOCD pipelines status before pushing your code

## Why gocd_pre_push?
When an agile team grows and becomes distributed, there comes a problem of keeping the pipelines green. To have less pipeline failures agile team follows one of the best practices, which is to not to push the code on a red pipeline. But how often we make an effort to open the GOCD dashboard and check the status of the pipelines. And the problem becomes worse when developer is not sure about what pipelines will be effected by their code.

gocd_pre_push helps developers by checking the status of concerned pipelines and allowing them to push only when all the pipelines are green.

## How to use it?
Its very simple to integrate gocd_pre_push with your project. All you have to do is add 'gocd_pre_push' in your Gemfile and start using it in your git pre_push hook.

##### Gemfile
```ruby
gem 'gocd_pre_push'
```

##### {project_root}/hooks/pre-push
```ruby
#!/usr/bin/ruby

require 'gocd_pre_push'

include GOCD_PRE_PUSH

gocd_server = GocdServer.with do |server|
  server.url      = 'http://yourgocdserverurl.com'
  server.username = 'your_gocd_username'
  server.password = 'your_gocd_password'
end

suspects_found = BuildOfficer.new('/path/to/pipelines.yml', gocd_server).investigate

if suspects_found
  abort 'Can not push!'
else
  print "All dependent pipelines are green! You can push your changes :)\n"
end
```

##### pipelines.yml
```yml
- pipeline: MyAwesomeProject
  stages:
    - spec
    - integration
    - generate_artifacts
- pipeline: MyAwesomeProject_Smoke
  stages:
    - smoke
```
