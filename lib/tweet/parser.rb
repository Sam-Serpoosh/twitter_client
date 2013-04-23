require 'json'
require_relative "./tweet_factory"

module Twitter
  class Parser
    def initialize(twitter_factory = Factory.new)
      @twitter_factory = twitter_factory
    end

    def get_tweets(all_tweets_data)
      tweets = JSON.parse all_tweets_data
      tweets.map do |t|
        @twitter_factory.create_tweet(t)
      end
    end
  end
end
