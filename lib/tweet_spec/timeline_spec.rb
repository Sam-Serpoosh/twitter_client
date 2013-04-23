require_relative "../tweet/timeline"

module Twitter
  describe Timeline do
    it "specifies the user and tweet counts" do
      screen_name = "masihjesus"
      timeline = Timeline.new(screen_name)
      timeline.screen_name.should == screen_name
      timeline.count.should == 20
    end

    it "has the path for twitter timeline API" do
      timeline = Timeline.new("masihjesus")
      timeline.api_path.should == "1.1/statuses/user_timeline.json"
    end 

    it "should include retweets by default" do
      timeline = Timeline.new("masihjesus")
      timeline.should be_include_rts
    end
  end
end
