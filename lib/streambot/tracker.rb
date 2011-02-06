module StreamBot

  # The Tracker class that provides a start and a stop method
  # This class has serveral callback methods
  class Tracker
    extend StreamBot::EventHandler
    events :on_error, :on_match
    attr_accessor :auth, :params

    def initialize(params)
      self.params = params
      @retweet = StreamBot::Retweet.new(self.params)
      @client = TwiStream::Client.new(authentication)
      @client.on_error do |msg, trace|
        on_error.trigger(msg, trace)
      end
    end

    def start
      keywords = self.params["keywords"]
      filters = self.params["filters"]
      @client.filter_by_keywords(keywords) do |status|
        # one thread per retweet, 
        # cause it's much, much faster
        @thread = Thread.new do
          @retweet.retweet(status["id"])
        end
      end
    end
    
    def stop
      @client.stop
    end
    
    private
    def authentication
      auth = self.params["auth"]
      {:user => auth["username"], :pass => auth["password"]}
    end
  end
end
