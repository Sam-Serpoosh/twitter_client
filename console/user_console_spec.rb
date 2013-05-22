require_relative "./user_console"
require_relative "../lib/tweet_spec/data"

class TwitterLib; end

module Twitter
  describe UserConsole do
    let(:tweets_data) { Data.timeline }

    it "gets the latest tweets from TwitterLib" do
      TwitterLib.should_receive(:user_timeline) { tweets_data }
      tweets = subject.latest_timeline("does not matter here")
      tweets.count.should == 20
    end

    it "gets the latest mentions from TwitterLib" do
      TwitterLib.should_receive(:mentions_timeline) { tweets_data }
      tweets = subject.latest_mentions
      tweets.count.should == 20
    end

    it "gets latest retweets TwitterLib" do
      TwitterLib.should_receive(:retweets) { tweets_data }
      tweets = subject.latest_retweets
      tweets.count.should == 20
    end
  end
end
