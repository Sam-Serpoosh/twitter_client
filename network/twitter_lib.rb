require_relative "./twitter_network"
require_relative "../lib/tweet/authenticate"
require_relative "../lib/tweet/timeline"
require_relative "../lib/tweet/mention"
require_relative "../lib/tweet/retweet"
require_relative "../lib/tweet/parser"
require_relative "../lib/tweet/following"
require_relative "../lib/tweet/friends_cursor"

module Twitter
  module TwitterLib
    def self.authenticate
      authenticate = Authenticate.new
      response = Network.fetch_response(authenticate.api_path)
      Parser.new.authentication_result(response)
    end

    def self.user_timeline(screen_name, count = 20)
      timeline = Timeline.new(screen_name, count: count)
			response = timeline.fetch_response
      get_tweets response
    end

    def self.mentions_timeline
      mention = Mention.new
      response = mention.fetch_mentions
      get_tweets response
    end

    def self.retweets
      rt = Retweet.new
      response = rt.fetch_retweets
      get_tweets response
    end

    def self.friends_latest_tweets
      tweets = []
      friends.each do |friend|
        tweets += user_timeline(friend.screen_name, 1)
      end
      tweets
    end

    private

    def self.get_tweets(response)
      Parser.new.get_tweets response
    end

    def self.friends
      current_cursor = starting_cursor
      user = User.new("masihjesus")
      while current_cursor.has_next?
        following = create_following(current_cursor)
        response = Network.fetch_response(following.api_path, 
                                          following.query)
        following.add_friends_to_user(user, response)
        current_cursor = following.next_cursor
      end
      user.friends
    end

    def self.starting_cursor
      Cursor.new(0, -1)
    end

    def self.create_following(cursor = Cursor.new(0, -1))
      Following.new("masihjesus", cursor_value: cursor.next_cursor)
    end
  end
end
