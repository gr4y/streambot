require 'net/http'
require 'open-uri'

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
    req.basic_auth @auth[:username],@auth[:password]
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res
      when Net::HTTPSuccess, Net::HTTPRedirection
      #OK
    else
      res.error!
    end
  end
  
end