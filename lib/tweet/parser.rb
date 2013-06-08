require 'json'
require_relative "./tweet_factory"
require_relative "./user"
require_relative "./cursor"

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
      if any_error?(tweets)
        puts "No Response Available!"
        [] #TODO: get rid of this
      else
        tweets.map do |t|
          @twitter_factory.create_tweet(t)
        end
      end
    end

    def create_cursor_for(response)
      friends_response = JSON.parse(response)
      if any_error?(friends_response)
        Cursor.new(0, 0) #last cursor
      else
        Cursor.new(friends_response["previous_cursor"], 
                   friends_response["next_cursor"])
      end
    end

    def users_from(friends_json)
      friends_data = JSON.parse(friends_json)
      users_data = friends_data["users"]
      users = []
      return users if users_data.nil?
      users_data.each do |user_data|
        users << User.new(user_data["id"], user_data["screen_name"])
      end
      users
    end

    private

    def any_error?(response)
      response.is_a?(Hash) && response.has_key?("errors")
    end
  end
end
