module StreamBot

  # The Tracker class that provides a start and a stop method
  # This class has serveral callback methods
  class Tracker
    extend StreamBot::EventHandler
    events :on_error
    attr_accessor :auth, :params

    def initialize(params)
      self.params = params
      @client = TwiStream::Client.new({:user => self.params["username"], :pass => self.params["password"]})
      @client.on_error do |msg, trace|
        on_error.trigger(msg, trace)
      end
    end

    def start
      @client.filter_by_keywords(self.params["keywords"]) do |status|
        puts status
      end
    end

    def stop
      @client.stop
    end

  end

end
