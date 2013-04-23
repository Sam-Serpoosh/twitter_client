require 'json'
require_relative "./tweet"

module Twitter
  class Factory
    def create_tweet(tweet)
      Tweet.new(tweet["id"], 
                tweet["user"]["screen_name"], 
                tweet["text"])
    end
  end
end
