require 'json'
require_relative "./tweet"

module Twitter
  class Client
    def initialize(tweet_data)
      @tweet_data = tweet_data
    end

    def create_tweet
      Tweet.new(@tweet_data["user"]["screen_name"], 
                @tweet_data["text"])
    end
  end
end
