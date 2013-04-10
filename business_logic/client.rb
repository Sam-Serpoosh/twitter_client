require 'json'
require_relative "./tweet"

module Twitter
  class Client
    def create_tweet(tweet)
      Tweet.new(tweet["user"]["screen_name"], 
                tweet["text"])
    end
  end
end
