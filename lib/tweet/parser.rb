require 'json'
require_relative "./tweet_factory"
require_relative "./user"
require_relative "./friends_cursor"

module Twitter
  class Parser
    def initialize(twitter_factory = Factory.new)
      @twitter_factory = twitter_factory
    end

    def authentication_result(authenticate_response)
      auth_data = JSON.parse(authenticate_response)
      if auth_data.has_key?("name") && 
         !auth_data["name"].nil? &&
         auth_data["name"] != ""
        return "Authenticated"
      end
      "Not Valid"
    end

    def get_tweets(all_tweets_data)
      tweets = JSON.parse all_tweets_data
      tweets.map do |t|
        @twitter_factory.create_tweet(t)
      end
    end

    def create_friends_cursor_for(response)
      friends_cursor = JSON.parse(response)
      check_error_in_response(friends_cursor)
      FriendsCursor.new(friends_cursor["previous_cursor"], 
                        friends_cursor["next_cursor"],
                        friends_cursor["users"])
    end

    def users_from(friends_cursor)
      users_data = friends_cursor.users_data
      users = []
      return users if users_data.nil?
      users_data.each do |user_data|
        users << User.new(user_data["id"], user_data["screen_name"])
      end
      users
    end

    private

    def check_error_in_response(response)
      if response.has_key?("errors")
        puts "No Response Available!"
      end
    end
  end
end
