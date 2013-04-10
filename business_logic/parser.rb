require 'json'
require_relative "./client"

module Twitter
  class Parser
    def initialize(twitter_client = Client.new)
      @twitter_client = twitter_client
    end

    def get_tweets(all_tweets_data)
      tweets = JSON.parse all_tweets_data
      tweets.map do |t|
        @twitter_client.create_tweet(t)
      end
    end
  end
end
