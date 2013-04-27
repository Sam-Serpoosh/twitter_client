require 'json'
require_relative "./tweet_factory"
require_relative "./user"
require_relative "./friends_cursor"

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

    def friends_cursor(friends_cursor_json)
      cursor_data = JSON.parse friends_cursor_json
      FriendsCursor.new(cursor_data["previous_cursor"], 
                        cursor_data["next_cursor"],
                        cursor_data["users"])
    end

    def users_from(friends_cursor)
      users_data = friends_cursor.users_data
      users = []
      users_data.each do |user_data|
        users << User.new(user_data["id"], user_data["screen_name"])
      end
      users
    end
  end
end
