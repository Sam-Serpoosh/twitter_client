require_relative "../../network/twitter_network"
require_relative "./cursor"
require_relative "./timeline"
require_relative "./parser"

module Twitter
  class Following
    attr_reader :screen_name, :next_cursor_value, :skip_status, 
                :include_user_entities, :query

    def initialize(screen_name, options = {})
      @screen_name = screen_name
      @next_cursor_value = options[:cursor_value] || -1
      @skip_status = options[:skip_status] || true
      @include_user_entities = options[:include_user_entities] || false
      @network = options[:network] || Network
      @parser = Parser.new
      set_query(@next_cursor_value)
    end

    def friends_latest_tweets
      tweets = []
      friends.each do |friend|
        tweets += user_timeline(friend.screen_name, 1)
      end
      tweets
    end

    def friends
      current_cursor = Cursor.new(0, -1)
      user = User.new(@screen_name)
      while current_cursor.has_next?
        set_query(current_cursor.next_cursor)
        response = @network.fetch_response(api_path, query)
        add_friends_and_move_to_next_cursor(user, response)
        current_cursor = next_cursor
      end
      user.friends
    end

    def add_friends_and_move_to_next_cursor(user, friends_response)
      @next_cursor = @parser.create_cursor_for(friends_response)
      friends = @parser.users_from(friends_response)
      user.add_friends(friends)
    end

    def user_timeline(screen_name, count = 1)
      timeline = Timeline.new(screen_name, count: count)
			response = timeline.fetch_response
      @parser.get_tweets response
    end

    def api_path
      "1.1/friends/list.json"
    end    

    def next_cursor
      @next_cursor
    end

    private

    def set_query(cursor_value)
      @query = @network.create_query(
        "screen_name" => @screen_name, 
        "cursor" => cursor_value,
        "skip_status" => skip_status,
        "include_user_entities" => include_user_entities)
    end
  end
end
