require 'json'

module Twitter
  class Client
    def initialize(tweet_json)
      @tweet_data = JSON.parse tweet_json
    end

    def create_tweet
      Tweet.new(@tweet_data["user"]["screen_name"], 
                @tweet_data["text"])
    end
  end

  class Tweet
    attr_reader :screen_name, :text

    def initialize(screen_name, text)
      @screen_name = screen_name
      @text = text
    end
  end
end
