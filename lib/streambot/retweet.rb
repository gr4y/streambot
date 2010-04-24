module StreamBot
  # wrapper class for dealing with twitters native retweet api
  class Retweet
    # api base url   
    $BASE_URL = "http://api.twitter.com/1/" 
    
    # intitialize method aka constructor
    def initialize(auth)
      @auth = auth
      @http = StreamBot::HTTP.new
    end
    
    # retweets the status with given id
    def retweet(id)
      LOG.debug("#{self.class}#retweet")
      url = URI.parse("#{$BASE_URL}statuses/retweet/#{id}.json")
      res = @http.post_with_auth(@auth, url)
      case res
        when Net::HTTPSuccess then return res
      else 
        res.error!
      end
    end
  end
end
