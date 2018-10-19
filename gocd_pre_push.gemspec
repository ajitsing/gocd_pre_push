# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative './lib/gocd_pre_push/version.rb'

Gem::Specification.new do |s|
  s.name                        =   'gocd_pre_push'
  s.version                     =   GOCD_PRE_PUSH::VERSION
  s.summary                     =   'Check GoCD pipeline status before pushing your changes to central repo'
  s.description                 =   s.summary
  s.authors                     =   ['Ajit Singh']
  s.email                       =   'jeetsingh.ajit@gamil.com'
  s.license                     =   'MIT'
  s.homepage                    =   'https://github.com/ajitsing/gocd_pre_push.git'

  s.files                       =   `git ls-files -z`.split("\x0")
  s.executables                 =   s.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  s.test_files                  =   s.files.grep(%r{^(test|spec|features)/})
  s.require_paths               =   ["lib"]

  s.add_dependency                  'gocd', '~> 1.3'
  s.add_dependency                  'rake'
  s.add_development_dependency      "rspec"
end
