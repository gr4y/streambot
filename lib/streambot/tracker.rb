module StreamBot

  # The Tracker class that provides a start and a stop method
  # This class has serveral callback methods
  class Tracker
    extend StreamBot::EventHandler
    events :on_error, :on_match
    attr_accessor :auth, :params

    # initializes the tracker
    def initialize(params)
      self.params = params
      @retweet = StreamBot::Retweet.new(self.params)
      @client = TwiStream::Client.new(authentication)
      @client.on_error do |msg, trace|
        on_error.trigger(msg, trace)
      end
    end

    # start the tracker
    def start
      keywords = self.params["keywords"]
      @client.filter_by_keywords(keywords) do |status|
        if retweet?(status)
          # one thread per retweet, 
          # cause it's much, much faster
          @thread = Thread.new do
            @retweet.retweet(status["id"])
          end
        end
      end
    end
    
    # stop the tracker
    def stop
      @client.stop
    end
    
    private
    # returns the authentication object
    def authentication
      auth = self.params["auth"]
      {:user => auth["username"], :pass => auth["password"]}
    end
    
    # load the YAML file that is specified in the params
    def load_filters
      filters_config = self.params["filters_config" ]
      if !filters_config.nil? && File.exists?(filters_config)
        begin
          YAML::load_file(filters_config)
        rescue 
          on_error.trigger($!, $@)
        end
      end
    end

    # decide if the status is retweetable    
    def retweet?(status)
      filters = load_filters
      retweet = true
      if !filters.nil?
        filters.each_pair do |path, value|
          array = []
          array << value
          array.flatten.each do |aValue|
            path_value = ArrayPath.get_path(status, path)
            if path_value.eql?(aValue) || path_value.include?(aValue)
              LOG.info "filter matched on #{path} with #{aValue} in status ##{status['id']}"
              on_match.trigger(status)
              retweet = false
            end
          end
        end
      end
      retweet
    end
  end
end
