require 'streambot/base_test'

module StreamBot
  # the test for testing retweet functionality
  class TestRetweet < StreamBot::BaseTest
    # setup the test 
    def setup  
      super
      @id = 12355936428
      @retweet = StreamBot::Retweet.new(@auth)
      stub_request(:post, "http://#{@auth[:username]}:#{@auth[:password]}@api.twitter.com/1/statuses/retweet/#{@id}.json").to_return(:body => 'content')
    end
    
    # teardown the test
    # nil all instance variables
    def teardown
      @id, @retweet, @auth = nil
    end
    
    # retweet 
    def test_retweet
      # no permission to access web!
      WebMock.disable_net_connect!
      # retweet the given id
      response = @retweet.retweet(@id)
      # assertion
      assert_not_nil(response) 
      assert_equal('content',response.body)    
    end
  end
end