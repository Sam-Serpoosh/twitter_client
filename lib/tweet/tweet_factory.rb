require 'json'
require_relative "./tweet"

module Twitter
  class Factory
    def create_tweet(tweet_data)
      Tweet.new(tweet_data["id"], 
                tweet_data["user"]["screen_name"], 
                tweet_data["text"])
    end

    def create_empty_tweet
      Tweet.new(nil, nil, "")
    end
  end
end
