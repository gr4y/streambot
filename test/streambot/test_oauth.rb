require 'streambot/base_test'

module StreamBot
  # test for http wrapper class
  class TestOAuth < StreamBot::BaseTest
    # setup
    def setup
      WebMock.allow_net_connect!
      @oauth = StreamBot::OAuth.new
      WebMock.disable_net_connect!
    end

    def test_verify_credentials
      begin
        stub_request(:get, "http://api.twitter.com/account/verify_credentials.json").to_return(:body=> "response")
        res = @oauth.get('/account/verify_credentials.json')
        assert_not_nil(res)
        assert(res=="response")
      rescue RuntimeError => e
        puts e
      end
    end

    def test_post_update
      body = {:status => 'test status via oauth'}
      stub_request(:post, "http://api.twitter.com/statuses/update.json").to_return(:body=> "response")
      begin
        res = @oauth.post('/statuses/update.json',body)
        assert_not_nil(res)
        assert(res=="response")
      end
    end

    # nil all variables
    def teardown
      @oauth = nil
    end
  end
end