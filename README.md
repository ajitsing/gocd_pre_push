# gocd_pre_push
Check GOCD pipelines status before pushing your code

## Why gocd_pre_push?
When an agile team grows and becomes distributed, there comes a problem of keeping the pipelines green. To have less pipeline failures agile team follows one of the best practices, which is to not to push the code on a red pipeline. But how often we make an effort to open the GOCD dashboard and check the status of the pipelines. And the problem becomes worse when developer is not sure about what pipelines will be effected by their code.

gocd_pre_push helps developers by checking the status of concerned pipelines and allowing them to push only when all the pipelines are green.

## How to use it?
Its very simple to integrate gocd_pre_push with your project. All you have to do is add 'gocd_pre_push' in your Gemfile and start using it in your git pre_push hook.

### Gemfile
```ruby
gem 'gocd_pre_push'
```
###### OR

```bash
gem install gocd_pre_push
```

### What does it take to setup gocd_pre_push for my project
Well all it takes is a very simple command. Go to your projects root folder and execute below command:
```bash
gocd_pre_push create
```
### What does the above command do?
The above command will create pre-push hooks and pipelines.yml. It will also symlink the newly created pre-push hook with the ./git/hooks folder. Don't worry about your old hooks because they will be saved inside .git/hooks.old folder. Start tracking the {project_root}/hooks folder with git and whenever a change is required, do that in this folder, it will take care of updating the .git/hooks for you.

### This is how your {project_root}/hooks/pre-push will look like
```ruby
#!/usr/bin/env ruby

require 'gocd_pre_push'

include GOCD_PRE_PUSH

#Add your gocd server details here
gocd_server = GocdServer.with do |server|
  server.url      = 'http://yourgocdserverurl.com'
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
```

### Here is a sample of pipelines.yml
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

### Licence

```LICENSE
MIT License

Copyright (c) 2016 Ajit Singh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
