require 'rubygems'
require 'tweetstream'
require 'retweet'

class StreamBot
  
  # initialize method aka constructor  
  def initialize(auth, blacklist=nil, *keywords)
    @stream = TweetStream::Client.new(auth[:username],auth[:password])
    @retweet = Retweet.new(auth)
    @keywords=keywords.join(',')
    @blacklist=blacklist if !blacklist.nil?
  end
  
  # starts the bot
  def start
    @stream.track(@keywords) do |status|
      if !@blacklist.include?(status.user)
        #puts "#{status.text} - #{status.id}"
        @retweet.retweet(status.id)
      end
    end  
  end  
  
  # stop bot
  def stop
    @stream.stop
  end
  
end
