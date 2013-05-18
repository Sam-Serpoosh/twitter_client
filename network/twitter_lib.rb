require_relative "./twitter_network"
require_relative "../lib/tweet/timeline"
require_relative "../lib/tweet/mention"
require_relative "../lib/tweet/retweet"
require_relative "../lib/tweet/parser"
require_relative "../lib/tweet/following"
require_relative "../lib/tweet/friends_cursor"

module Twitter
  module TwitterLib
    def self.authenticate
      path = "1.1/account/verify_credentials.json"
      Network.fetch_response(path)
    end

    def self.user_timeline
      timeline = Timeline.new(Network::SCREEN_NAME)
      query = Network.create_query(
        "screen_name" => timeline.screen_name,
        "count" => timeline.count,
        "include_rts" => timeline.include_rts?)
      Network.fetch_response(timeline.api_path, query)
    end

    def self.mentions_timeline
      mention = Mention.new
      query = Network.create_query("count" => mention.count)
      Network.fetch_response(mention.api_path, query)
    end

    def self.retweets
      rt = Retweet.new
      query = Network.create_query("count" => rt.count)
      Network.fetch_response(rt.api_path, query)
    end

    def self.friends
      cursor = FriendsCursor.new(0, -1, [])
      while cursor.last? == false
        following = create_following(cursor)
        response = Network.fetch_response(following.api_path, following.query)
        parser = Parser.new
        user = User.new(nil, Network::SCREEN_NAME)
        cursor = parser.friends_cursor(response)
        user.add_friends(parser.users_from(cursor))
        puts user.friends
        puts "-" * 60
      end
    end

    private

    def self.create_following(cursor = FriendsCursor.new(0, -1, []))
      following = Following.new("masihjesus", cursor: cursor.next_cursor)
      following.query = Network.create_query(
        "screen_name" => following.screen_name, 
        "cursor" => following.cursor,
        "skip_status" => following.skip_status,
        "include_user_entities" => following.include_user_entities)
      following
    end
  end
end

#puts Twitter::TwitterLib.friends
