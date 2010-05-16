require 'streambot/base_test'

module StreamBot
  # test for http wrapper class
  class TestOAuth < StreamBot::BaseTest
    # setup
    def setup
      WebMock.allow_net_connect!
      @oauth = StreamBot::OAuth.new
    end

    def test_verify_credentials
      json = @oauth.get('/account/verify_credentials.json')
      puts json
    end

    # nil all variables
    def teardown
      @oauth = nil
    end
  end
end