require 'streambot/base_test'

module StreamBot
  # test for http wrapper class
  class TestHttp < StreamBot::BaseTest
    # setup 
    def setup
      super
      WebMock.disable_net_connect!
      @http = StreamBot::HTTP.new(@params['http'])
      stub_request(:post, "http://#{@params['http']['username']}:#{@params['http']['password']}@api.twitter.com/path/to/data").to_return(:body => "response")
    end

    # test a post with basic authentication
    def test_post
      res = @http.post('/path/to/data',nil)
      assert_not_nil(res)
      assert_equal("response", res)
    end

    # nil all variables
    def teardown
      @http = nil
      WebMock.allow_net_connect!
    end

  end
end