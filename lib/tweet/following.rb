module Twitter
  class Following
    attr_reader :screen_name, :cursor, :skip_status, 
                :include_user_entities

    def initialize(screen_name, cursor = -1, 
                   skip_status = true, include_user_entities = false)
      @screen_name = screen_name
      @cursor = cursor
      @skip_status = skip_status
      @include_user_entities = include_user_entities
    end

    def api_path
      "https://api.twitter.com/1.1/friends/list.json"
    end
  end
end
