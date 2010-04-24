require 'rubygems'
require 'yaml'
require 'test/unit'
require 'webmock'

include WebMock

# The base of all tests in this projet
# New Testcases need to look like this:
#
#
# class TestName < BaseTest
#  
#  def setup 
#    super
#    # implementation goes here
#  end
#  
# end
class BaseTest < Test::Unit::TestCase
  
  # reading config.yml and assign all keys to instance
  def read_config  
    yml_config = YAML.load_file(File.dirname(__FILE__) + "/config.yml")
    yml_config.each do |key, value| 
      instance_variable_set("@#{key}", value)
    end
  end
  
  # :nodoc:
  def setup
    self.read_config
  end
  
end