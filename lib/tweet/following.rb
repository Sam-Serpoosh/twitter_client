module Twitter
  class Following
    attr_reader :screen_name, :next_cursor, :skip_status, 
                :include_user_entities
    attr_accessor :query

    def initialize(screen_name, options = {})
      @screen_name = screen_name
      @next_cursor = options[:cursor] || -1
      @skip_status = options[:skip_status] || true
      @include_user_entities = options[:include_user_entities] || false
    end

    def api_path
      "1.1/friends/list.json"
    end
    
    def extract_and_add_friends_to_user(user, friends_response)
      parser = Parser.new
      @cursor = parser.create_friends_cursor_for(friends_response)
      friends = parser.users_from(@cursor)
      user.add_friends(friends)
    end

    def move_to_next_cursor
      @cursor
    end
  end
end
