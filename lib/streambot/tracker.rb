module StreamBot
  # The Tracker class that provides a start and a stop method
  # This class has serveral callback methods
  class Tracker
    extend StreamBot::Callbacks
    callbacks :before_start, :before_match, :match_filter, :before_retweet
    # the initialization method aka the constructor
    def initialize(params, blacklist, * keywords)
      LOG.debug("Tracker#initialize")
      http_auth = params['http']
      @stream = TweetStream::Client.new(http_auth['username'], http_auth['password'])
      @stream.on_error do |message|
        LOG.error "#{message}"
        @stream.stop
      end
      # initializing retweet
      @retweet = StreamBot::Retweet.new(params)
      # get string with keywords comma separated keywords 
      @keywords=keywords.join(',')
      # set blacklist array if not nil
      @blacklist=blacklist
      if !@blacklist.nil?
        warn "blacklisting is deprecated and will be removed with streambot 0.6.0"
      end
      @filters = params['filters']
    end

    # start the bot
    def start
      before_start
      LOG.debug("Tracker#start")
      # starting to track the keywords via tweetstream
      @stream.track(@keywords) do |status|
        # make status an instance variable for callbacks
        @status = status
        username = status.user.screen_name
        # if status.user is NOT in blacklist or filters don't match then retweet it
        before_match
        if (@blacklist.nil? || !@blacklist.include?(username)) && !@filters.nil?
          @filters.each do |key, value|
            if match?(status, value)
              match_filter
              LOG.debug("Tracker#start - filter #{key} matched!")
              break
            end
          end
        end
        before_retweet
        LOG.debug("Tracker#start - retweet ##{status.id} from @#{username}")
        @retweet.retweet(status.id)
      end
    end

    # returns true if an filter is matching
    def match?(status, filter)
      @type = filter["type"]
      @value = filter["value"]
      if @type == "USER" then
        status.user.screen_name.eql?(@value)
      elsif @type == "CONTENT" then
        status.text.include?(@value)
      elsif @type == "LANGUAGE" then
        status.user.lang.eql?(@value)
      end
    end

    # stop the bot
    def stop
      @stream.stop
    end
  end
end
