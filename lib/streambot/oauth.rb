module StreamBot
  # oauth communication wrapper
  class OAuth
    TWITTER_OAUTH_SPEC = {
            :site => 'http://api.twitter.com',
            :request_token_pat1h => '/oauth/request_token',
            :access_token_path => '/oauth/access_token',
            :authorize_path => '/oauth/authorize'
    }

    ACCESS_TOKEN = ::File.dirname(::File.expand_path(::File.dirname(__FILE__))) + ::File::SEPARATOR + 'access_token.yml'

    # :nodoc:
    def initialize
      load_config
      @oauth = @config['auth']['oauth']
      @oauth_consumer = ::OAuth::Consumer.new(@oauth['consumer']['key'], @oauth['consumer']['secret'], TWITTER_OAUTH_SPEC)
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
    def post(url, body)
      response = @access_token.post(url, body)
      parse_response(response)
    end

    # get data from twitter api
    #
    #   url takes the path like
    #     '/statuses/user_timeline.format'
    #
    def get(url)
      response = @access_token.get(url)
      parse_response(response)
    end

    private
    def parse_response(object)
      #LOG.debug(object.class)
      case object
        when ::Net::HTTPUnauthorized
          ::File.delete(ACCESS_TOKEN)
          raise 'user revoked oauth connection'
        when ::Net::HTTPOK
          object.body
      end
    end

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

    # load both, config and access token from its yml file
    def load_config
      @config = ::YAML.load_file('config.yml')
    end
  end
end