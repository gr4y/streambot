module StreamBot
  # wrapper class for dealing with twitters native retweet api
  class Retweet
    # intitialize method aka constructor
    def initialize(params)
      auth_type = params['auth_type']
      auth_params = params[auth_type]
      case auth_type
        when "oauth" then @handler = StreamBot::OAuth.new(auth_params)
        when "http" then @handler = StreamBot::HTTP.new(auth_params)
      end
    end

    # retweets the status with given id
    def retweet(id)
      @handler.post("/statuses/retweet/#{id}.json",nil)
    end
  end
end
