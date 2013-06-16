require_relative "../../lib/network/twitter_lib"

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

    it "gets friends list" do
      friends = TwitterLib.friends
      if friends.count > 0
        friends.count.should >= 130
        friends.select do |user|
          user.screen_name == "bahadorn"
        end.count.should == 1
        puts "Friends was tested properly!"
      end
      puts "Exceeded limit, friends was not tested!"
    end
  end
end
