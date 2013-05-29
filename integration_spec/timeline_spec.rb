require_relative "../network/twitter_lib"

module Twitter
  describe TwitterLib do
    it "gets user timeline" do
      timeline = TwitterLib.user_timeline("masihjesus")
      timeline.count.should == 20
    end

    it "gets user mentions" do
      mentions = TwitterLib.mentions_timeline
      mentions.count.should == 20
    end

    it "gets user retweets" do
      rets = TwitterLib.retweets
      rets.count.should == 20
    end 
  end
end
