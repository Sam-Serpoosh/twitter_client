require_relative "../../network/twitter_network"

module Twitter
  class Following
    attr_reader :screen_name, :next_cursor_value, :skip_status, 
                :include_user_entities, :query

    def initialize(screen_name, options = {})
      @screen_name = screen_name
      @next_cursor_value = options[:cursor_value] || -1
      @skip_status = options[:skip_status] || true
      @include_user_entities = options[:include_user_entities] || false
      set_query
    end

    def api_path
      "1.1/friends/list.json"
    end
    
    def add_friends_to_user(user, friends_response)
      parser = Parser.new
      @cursor = parser.create_cursor_for(friends_response)
      friends = parser.users_from(friends_response)
      user.add_friends(friends)
    end

    def next_cursor
      @cursor
    end

    private

    def set_query
      @query = Network.create_query(
        "screen_name" => screen_name, 
        "cursor" => next_cursor_value,
        "skip_status" => skip_status,
        "include_user_entities" => include_user_entities)
    end
  end
end
