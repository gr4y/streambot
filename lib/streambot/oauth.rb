module StreamBot
  # oauth communication wrapper
  class OAuth < StreamBot::Handler
    TWITTER_OAUTH_SPEC = {
            :site => 'http://api.twitter.com',
            :request_token_pat1h => '/oauth/request_token',
            :access_token_path => '/oauth/access_token',
            :authorize_path => '/oauth/authorize'
    }

    ACCESS_TOKEN = ::File.dirname(::File.expand_path(::File.dirname(__FILE__))) + ::File::SEPARATOR + 'access_token.yml'

    # :nodoc:
    def initialize(auth)
      @auth = auth      
      @oauth_consumer = ::OAuth::Consumer.new(@auth['key'], @auth['secret'], TWITTER_OAUTH_SPEC)
      get_access_token
    end

    # post data to twitter api
    #
    #   url takes the path like
    #     '/statuses/update.format'
    #
    #   the body contains all data you send to twitter
    #     {:status => "a new status"}
    #
    def post(path, body)
      LOG.debug("post #{body} to \"#{path}\"")
      response = @access_token.post(path, body)
      parse_response(response)
    end

    # get data from twitter api
    #
    #   path takes the path like
    #     '/statuses/user_timeline.format'
    #
    def get(path)
      LOG.debug("get data form \"#{path}\"")
      response = @access_token.get(path)
      parse_response(response)
    end

    private
    # get the request token from oauth consumer
    def get_request_token
      @oauth_consumer.get_request_token
    end

    # get the access token
    def get_access_token
      # get saved access token
      if ::File.exists?(ACCESS_TOKEN)
        @access_token = ::YAML.load_file(ACCESS_TOKEN)
      end
      # if access token is nil,
      # then get a new initial token
      if @access_token.nil?
        get_initial_token
        ::File.open(ACCESS_TOKEN, 'w') do |out|
          YAML.dump(@access_token, out)
        end
      end
    end

    # get the initial access token
    def get_initial_token
      @request_token = get_request_token
      puts "Place \"#{@request_token.authorize_url}\" in your browser"
      print "Enter the number they give you: "
      pin = STDIN.readline.chomp
      @access_token = @request_token.get_access_token(:oauth_verifier => pin)
    end
  end
end