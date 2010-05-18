module StreamBot
  # http communication wrapper
  class HTTP < StreamBot::Handler
    BASE_URL = "http://api.twitter.com"
    # intialize http communication wrapper
    def initialize(auth)
      @auth = auth
    end

    # post data to twitter api
    #
    #   path takes the path like
    #     '/statuses/update.format'
    #
    #   the body contains all data you send to twitter
    #     {:status => "a new status"}
    #
    def post(path, body)
      LOG.debug("post #{body} to \"#{path}\"")
      request = init_request(path, :post)
      request.body = body if !body.nil?
      do_request(request)
    end

    # get data from twitter api
    #
    #   path takes the path like
    #     '/statuses/user_timeline.format'
    #
    def get(path)
      LOG.debug("get data form \"#{path}\"")
      request = init_request(path, :get)
      do_request(request)
    end

    private
    def do_request(request)
      request.basic_auth @auth[:username], @auth[:password]
      response = Net::HTTP.new(@uri.host, @uri.port).start do |http|
        http.request(request)
      end
      parse_response(response)
    end

    # initialize an Net::HTTP::GET or Net::HTTP::POST request
    # depends on type param
    def init_request(path, type)
      @url = "#{BASE_URL}#{path}"
      @uri = URI.parse(@url)
      case type
        when :post then
          Net::HTTP::Post.new(@uri.path)
        when :get then
          Net::HTTP::Get.new(@uri.path)
      end
    end
  end
end