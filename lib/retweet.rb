require 'net/http'
require 'open-uri'

# wrapper class for dealing with twitters native retweet api
# it simply connects to twitter api via http basic auth with given credentials
class Retweet
  
  # intitialize method aka constructor
  def initialize(auth)
    return if auth.nil?
    @auth = auth 
  end
  
  # retweets the status with given id
  def retweet(id)
    url = URI.parse("http://api.twitter.com/1/statuses/retweet/#{id}.json")
    req = Net::HTTP::Post.new(url.path)
    # set credentials
    req.basic_auth @auth[:username],@auth[:password]
    # connect
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req)}
    case res
      when Net::HTTPSuccess then return res
    else 
      res.error!
    end
  end
  
end