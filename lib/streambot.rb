require 'rubygems'
require 'open-uri'
require 'net/http'
require 'oauth'
require 'tweetstream'
require 'logger'
require 'yaml'

require 'streambot/tracker'
require 'streambot/retweet'
require 'streambot/handler'
require 'streambot/http'
require 'streambot/oauth'

module StreamBot  
  LOG = Logger.new(STDOUT)
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
end