require_relative "./twitter_client"
require_relative "./data"

module Twitter
  describe Client do
    context "#tweet_data_parsing" do
      it "creates a tweet from raw data" do
        tweet = subject.create_tweet(one_tweet_data)
        tweet.screen_name.should == "masihjesus"
        tweet.text.should == 
          "Do a little bit of something &amp; get some feedback from it as quick as U can! It is not just for programming! This is also good habit in life!"
      end
    end

    def one_tweet_data
      JSON.parse Data.one_tweet
    end
  end
end