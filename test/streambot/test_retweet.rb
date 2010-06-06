require 'streambot/base_test'

module StreamBot
  # the test for testing retweet functionality
  class TestRetweet < StreamBot::BaseTest
    # setup the test 
    def setup
      super
      @retweet = StreamBot::Retweet.new(@params)
      if @params['auth_type'] == "oauth"
        stub_request(:post, "http://api.twitter.com/statuses/retweet/12355936428.json").to_return(:body => "response")
      elsif @params['auth_type'] == "http"
        stub_request(:post, "http://#{@params['http']['username']}:#{@params['http']['password']}@api.twitter.com/statuses/retweet/12355936428.json").to_return(:body => "response")
      end
    end

    # retweet
    def test_retweet
      # no permission to access web!
      WebMock.disable_net_connect!
      # retweet the given id
      response = @retweet.retweet(@id)
      # assertion
      assert_not_nil(response)
      assert_equal("response", response)
    end

    # teardown the test
    # nil all instance variables
    def teardown
      @id, @retweet = nil
    end
  end
end