require 'streambot/base_test'

module StreamBot
  # test for http wrapper class
  class TestHttp < StreamBot::BaseTest
    # setup 
    def setup
      @http = StreamBot::HTTP.new
      # override auth
      @auth = {:username=>'test', :password=>'test'}
      stub_request(:post, "http://test:test@testing.com/path/to/data").to_return(:body => @auth)
    end

    # nil all variables
    def teardown
      @http = nil
    end

    # test a post with basic authentication
    def test_post
      WebMock.disable_net_connect!
      res = @http.post_with_auth(@auth, 'http://testing.com/path/to/data')
      assert_not_nil(res)
      assert_equal(@auth, res.body)
    end
  end
end