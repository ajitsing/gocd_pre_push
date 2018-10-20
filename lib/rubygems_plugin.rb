require 'rubygems'
require 'bundler'
require_relative 'gocd_pre_push/linker'

Gem.post_install do |_installer|
  GOCD_PRE_PUSH::Linker.new.symlink_git_hooks
end
