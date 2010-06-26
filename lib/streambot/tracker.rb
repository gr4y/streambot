module StreamBot
  # The Tracker class that provides a start and a stop method 
  class Tracker
    # the initialization method aka the constructor
    def initialize(params, blacklist, * keywords)
      LOG.debug("Tracker#initialize")
      http_auth = params['http']
      @stream = TweetStream::Client.new(http_auth['username'], http_auth['password'])
      # initializing retweet
      @retweet = StreamBot::Retweet.new(params)
      # get string with keywords comma separated keywords 
      @keywords=keywords.join(',')
      # set blacklist array if not nil
      @blacklist=blacklist
      if !@blacklist.nil?
        warn "blacklisting is deprecated and will be removed with streambot 0.6.0"
      end
    end

    # start the bot
    def start
      LOG.debug("Tracker#start")
      # starting to track the keywords via tweetstream
      @stream.track(@keywords) do |status|
        username = status.user.screen_name
        # if status.user is NOT in blacklist or filters don't match then retweet it
        if !@blacklist.include?(username) || !match?(status)
          LOG.debug("Tracker#start - retweet ##{status.id} from @#{username}")
          @retweet.retweet(status.id)
        end
      end
    end

    # returns true if an filter is matching
    def match?(status)
      filters = params['filters']
      filters.each do |filter|
        @type = filter['type']
        @value = filter['value']
        case @type
          when "USER" then
            status.user.screen_name.eql?(@value)
          when "CONTENT" then
            status.text.include?(@value)
          when "LANGUAGE" then
            status.lang.eql?(@value)
        end
      end
    end

    # stop the bot
    def stop
      @stream.stop
    end
  end
end