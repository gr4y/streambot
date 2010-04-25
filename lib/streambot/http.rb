module StreamBot
  # http communication wrapper
  class HTTP
    # initialize request with basic authentication and send
    def post_with_auth(auth, url)
      uri = URI.parse(url)
      request = init_request(uri)
      request.basic_auth auth[:username],auth[:password]
      post_request(request,uri)
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
      LOG.debug("#{self.class}#init_request(#{url})")
      puts url.inspect
      Net::HTTP::Post.new(url.path)
    end
  end
end