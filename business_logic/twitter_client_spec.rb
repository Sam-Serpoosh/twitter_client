require_relative "./twitter_client"

describe Twitter::Client do
  context "#tweet_data_parsing" do
    before do
      @client = Twitter::Client.new(read_data)
    end

    it "creates a tweet from raw data" do
      tweet = @client.create_tweet
      tweet.screen_name.should == "masihjesus"
      tweet.text.should == 
        "Do a little bit of something &amp; get some feedback from it as quick as U can! It is not just for programming! This is also good habit in life!"
    end
  end

  def read_data
    File.open("json_data.data", "r") do |f|
      f.read
    end
  end
end