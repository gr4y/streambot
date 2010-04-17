require 'rubygems'
require 'test/unit'
require 'webmock'
require 'retweet'

include WebMock

# the test for testing retweet functionality
class TestRetweet <  Test::Unit::TestCase
  
  # setup the test 
  def setup
    # authentication to my test-account on twitter
    auth = {:username=>'gr4ydev',:password=>'afe5fek3'}
    # actually used one of my own tweets
    @id = 12355936428
    # initialize retweet
    @retweet = Retweet.new(auth)
    # stubbing (actually webmock does the magic here)
    stub_request(:post, "http://#{auth[:username]}:#{auth[:password]}@api.twitter.com/1/statuses/retweet/#{@id}.json").to_return(:body => 'content')
  end
  
  # teardown the test
  def teardown
    # nil all recent variables
    @id, @retweet = nil
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
