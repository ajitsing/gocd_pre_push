require 'ostruct'

module GOCD_PRE_PUSH
  class GocdServer
    def self.with
      server = OpenStruct.new
      yield server
      server
    end
  end
end