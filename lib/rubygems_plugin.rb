require 'rubygems'
require 'bundler'

Gem.post_install do |_installer|
  p "Installed gocd_pre_push successfully!!"
end
