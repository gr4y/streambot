require 'rubygems'
require 'open-uri'
require 'net/http'
require 'tweetstream'
require 'logger'

require 'streambot/tracker'
require 'streambot/retweet'
require 'streambot/http'

module StreamBot  
  LOG = Logger.new(STDOUT)
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
end