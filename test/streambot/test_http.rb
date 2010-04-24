module StreamBot
  
  class TestHTTP < StreamBot::BaseTest
    
    def setup
      super
      @http = StreamBot::HTTP.new
      stub_request(:post,"http://#{@auth[:username]}:#{@auth[:password]}@testing.com/path/to/data").to_return(:body => @auth)
    end
   
    def test_http
      WebMock.disable_net_connect!
      res = @http.post_with_auth(@auth, 'http://testing.com/path/to/data')
      assert_not_nil(res)
      assert_equal(@auth,res.body)
    end
       
  end
  
end