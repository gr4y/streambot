require 'spec_helper'

describe StreamBot::Tracker do
  
  before :all do
    params = YAML.load_file('spec/params.yml')
    @tracker = StreamBot::Tracker.new(params)
  end
  
  describe "#start" do
    it "should start" do
      @tracker.start
    end
  end
  
  describe "wait" do 
    it "should sleep for 60 seconds" do 
      sleep 60
    end
  end
  
  describe "#stop" do 
    it "should stop" do 
      @tracker.stop
    end
  end
  
end
