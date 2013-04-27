module Twitter
  class Following
    attr_reader :screen_name, :cursor, :skip_status, 
                :include_user_entities

    def initialize(screen_name, options = {})
      @screen_name = screen_name
      @cursor = options[:cursor] || -1
      @skip_status = options[:skip_status] || true
      @include_user_entities = options[:include_user_entities] || false
    end

    def api_path
      "https://api.twitter.com/1.1/friends/list.json"
    end
  end
end
