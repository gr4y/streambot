module StreamBot
  # http communication wrapper
  class HTTP
    # initialize request with basic authentication and send
    def post_with_auth(auth, url)
      request = init_request(url)
      request.basic_auth auth[:username],auth[:password]
      post_request(request,url)
    end
        
    private
    # send request
    def post_request(request,url)
      Net::HTTP.new(url.host, url.port).start { |http|
        LOG.debug("#{http.inspect}")
        http.request(request) 
      }
    end
    
    # initialize an Net::HTTP::Post Request
    def init_request(url)
      Net::HTTP::Post.new(url.path)
    end
  end
end