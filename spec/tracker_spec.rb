require 'spec_helper'

describe StreamBot::Tracker do
  
  before :all do
    params = YAML.load_file('spec/params.yml')
    @tracker = StreamBot::Tracker.new(params)
  end
  
  describe "#start" do
    it "should start" do
      @tracker.start
      sleep 1000
      @tracker.stop
    end
  end
end
