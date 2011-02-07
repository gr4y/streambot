require 'rubygems'
require 'open-uri'
require 'net/http'
require 'oauth'
require 'twistream'
require 'logger'
require 'yaml'

require 'streambot/event'
require 'streambot/event_handler'
require 'streambot/retweet'
require 'streambot/handler'
require 'streambot/oauth'
require 'streambot/array_path'
require 'streambot/tracker'

module StreamBot
  LOG = Logger.new(STDOUT)
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  VERSION = ::File.exist?('VERSION') ? ::File.read('VERSION') : ""
end