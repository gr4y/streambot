module StreamBot
  # The Tracker class that provides a start and a stop method 
  class Tracker
    # the initialization method aka the constructor
    def initialize(params, blacklist, *keywords)
      LOG.debug("Tracker#initialize")
      http_auth = params['http']
      @stream = TweetStream::Client.new(http_auth['username'],http_auth['password'])
      # initializing retweet
      @retweet = StreamBot::Retweet.new(params)
      # get string with keywords comma separated keywords 
      @keywords=keywords.join(',')
      # set blacklist array if not nil
      @blacklist=blacklist
    end
    
    # start the bot
    def start
      LOG.debug("Tracker#start")
      # starting to track the keywords via tweetstream
      @stream.track(@keywords) do |status|
        username = status.user.screen_name
        # if status.user is NOT in blacklist then retweet it
        if !@blacklist.include?(username)
          LOG.debug("Tracker#start - retweet ##{status.id} from @#{username}")
          @retweet.retweet(status.id)
        end
      end  
    end  
    
    # stop the bot
    def stop
      @stream.stop
    end
  end
end