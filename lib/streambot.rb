require 'rubygems'
require 'tweetstream'
require 'retweet'

class StreamBot
  
  def initialize(auth, *keywords)
    @stream = TweetStream::Client.new(auth[:username],auth[:password])
    @retweet = Retweet.new(auth)
    @keywords=keywords.join(',')
  end
  
  def start
    @stream.track(@keywords) do |status|
      puts "#{status.text} - #{status.id}"
      @retweet.retweet(status.id)
    end  
  end  
  
  def stop
    @stream.stop
  end
  
end
