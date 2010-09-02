module StreamBot
  # wrapper class for dealing with twitters native retweet api
  class Retweet
    # intitialize method aka constructor
    def initialize(params)
      @handler = StreamBot::OAuth.new(params['oauth'])
    end

    # retweets the status with given id
    def retweet(id)
      @handler.post("/statuses/retweet/#{id}.json",nil)
    end
  end
end
