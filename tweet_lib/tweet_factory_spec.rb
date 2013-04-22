require_relative "./tweet_factory"
require_relative "./data"

module Twitter
  describe Factory do
    context "#tweet_data_parsing" do
      it "creates a tweet from raw data" do
        tweet = subject.create_tweet(one_tweet_data)
        tweet.id.should == 321734667248226305 
        tweet.screen_name.should == "masihjesus"
        tweet.text.should include("Do a little bit of")
      end
    end

    def one_tweet_data
      # read from test file which stored a sample
      JSON.parse Data.one_tweet
    end
  end
end