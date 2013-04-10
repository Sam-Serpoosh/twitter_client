require_relative "./twitter_client"

module Twitter
  describe Client do
    context "#tweet_data_parsing" do
      before do
        @client = Twitter::Client.new(individual_tweet_hash)
      end

      it "creates a tweet from raw data" do
        tweet = @client.create_tweet
        tweet.screen_name.should == "masihjesus"
        tweet.text.should == 
          "Do a little bit of something &amp; get some feedback from it as quick as U can! It is not just for programming! This is also good habit in life!"
      end
    end

    def individual_tweet_hash
      data_path = File.expand_path(File.dirname(__FILE__) + "/one_tweet.data")
      tweet = File.open(data_path, "r") do |f|
        f.read
      end
      JSON.parse tweet
    end
  end
end