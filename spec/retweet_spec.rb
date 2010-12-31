require 'spec_helper'

describe StreamBot::Retweet do

  before :all do 
    params = YAML.load_file('spec/params.yml')
    @retweet = StreamBot::Retweet.new(params)
  end
  
  describe "#retweet" do
  end

end