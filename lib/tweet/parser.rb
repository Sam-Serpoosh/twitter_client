require 'json'
require_relative "./tweet_factory"
require_relative "./user"

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

    def users_from(users_json)
      users_data_array = JSON.parse(users_json)["users"]
      users = []
      users_data_array.each do |user_data|
        users << User.new(user_data["id"], user_data["screen_name"])
      end
      users
    end
  end
end
