module StreamBot
  # oauth communication wrapper
  class OAuth
    TWITTER_OAUTH_SPEC = {
            :site => 'http://api.twitter.com',
            :request_token_pat1h => '/oauth/request_token',
            :access_token_path => '/oauth/access_token',
            :authorize_path => '/oauth/authorize'
    }

    def initialize
      load_config
      @oauth = @config['auth']['oauth']
      @oauth_consumer = ::OAuth::Consumer.new(@oauth['consumer']['key'], @oauth['consumer']['secret'], TWITTER_OAUTH_SPEC)
    end

    def post(url)
      @access_token.post(url)
    end

    def get(url)
      @access_token.get(url)
    end
    
    private
    def get_request_token
      @oauth_consumer.get_request_token
    end

    def get_access_token
      if @access_token.nil?
        get_initial_token
        File.open(PATH+'access_token.yml', 'w') do |out|
          YAML.dump(@access_token, out)
        end
      end
    end

    def get_initial_token
      @request_token = get_request_token
      puts "Place \"#{@request_token.authorize_url}\" in your browser"
      print "Enter the number they give you: "
      pin = STDIN.readline.chomp
      @access_token = @request_token.get_access_token(:oauth_verifier => pin)
    end

    def load_config
      @config = YAML.load_file('config.yml')
      if File.exists?('access_token.yml')
        @access_token = YAML.load_file('access_token.yml')
      end
    end
  end
end