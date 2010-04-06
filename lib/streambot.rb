require 'rubygems'
require 'tweetstream'

class StreamBot
  
  def initialize(auth, *keywords)
    #@client = Grackle::Client.new(auth)
    @stream = TweetStream::Client.new(auth[:username],auth[:password])
    @keywords=keywords.join(',')
  end
  
  def start
    @stream.track(@keywords) do |status|
      puts "#{status.text} from [#{status.user.screen_name}]"
    end  
  end  
  
  def stop
    @stream.stop
  end
  
end
