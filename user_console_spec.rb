require_relative "./user_console"
require_relative "./tweet_lib/data"

class Http; end

module Twitter
  describe UserConsole do
    let(:tweets_data) { Data.timeline }

    it "gets the latest tweets from Http" do
      Http.should_receive(:user_timeline) { tweets_data }
      tweets = subject.latest_timeline
      tweets.count.should == 20
    end

    it "gets the latest mentions from Http" do
      Http.should_receive(:mentions_timeline) { tweets_data }
      tweets = subject.latest_mentions
      tweets.count.should == 20
    end

    it "gets latest retweets Http" do
      Http.should_receive(:retweets) { tweets_data }
      tweets = subject.latest_retweets
      tweets.count.should == 20
    end
  end
end
