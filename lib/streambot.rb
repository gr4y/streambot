require 'rubygems'
require 'tweetstream'
require 'retweet'

# The StreamBot class that provides a start and a stop method 
class StreamBot
  
  # the initialization method aka the constructor
  def initialize(auth, blacklist, *keywords)
    @stream = TweetStream::Client.new(auth[:username],auth[:password])
    # initializing retweet
    @retweet = Retweet.new(auth) #
    # get string with keywords comma separated keywords 
    @keywords=keywords.join(',')
    # set blacklist array if not nil
    @blacklist=blacklist
  end
  
  # start the bot
  def start
    # starting to track the keywords via tweetstream
    @stream.track(@keywords) do |status|
      # if status.user is NOT in blacklist then retweet it
      if !@blacklist.include?(status.user) 
        #puts "#{status.text} - #{status.id}"
        @retweet.retweet(status.id)
      end
    end  
  end  
  
  # stop the bot
  def stop
    @stream.stop
  end
  
end
