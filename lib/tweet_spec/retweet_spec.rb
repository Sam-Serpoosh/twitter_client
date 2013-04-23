require_relative "../tweet/retweet"

module Twitter
  describe Retweet do
    it "knows the path for th api" do
      subject.api_path.should == "1.1/statuses/retweets_of_me.json"
    end

    it "has 20 as the default count limit" do
      subject.count.should == 20
    end

    it "can change the count limit" do
      Retweet.new(30).count.should == 30
    end
  end
end
