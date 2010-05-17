require 'streambot/base_test'

module StreamBot
  # test for http wrapper class
  class TestOAuth < StreamBot::BaseTest
    # setup
    def setup
      super
      WebMock.allow_net_connect!
      @oauth = StreamBot::OAuth.new(@params['oauth'])
      stub_request(:post,"http://api.twitter.com/statuses/update.json").to_return(:body=>"response")
    end

    def test_verify_credentials
      json = @oauth.get('/account/verify_credentials.json')
      assert_not_nil(json)
    end

    def test_post
      WebMock.disable_net_connect!
      json = @oauth.post('/statuses/update.json',{:status => 'test'})
      assert_not_nil(json)
      assert_equal("response",json)
    end

    # nil all variables
    def teardown
      @oauth = nil
    end
  end
end