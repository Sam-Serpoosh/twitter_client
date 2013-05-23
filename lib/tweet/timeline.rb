require_relative "../../network/twitter_network"

module Twitter
  class Timeline
    attr_reader :screen_name, :count, :query

    def initialize(screen_name, count = 20)
      @screen_name = screen_name
      @count = count
      set_query
    end

    def include_rts?
      1
    end

    def api_path
      "1.1/statuses/user_timeline.json"
    end

    private

    def set_query
      @query = Network.create_query(
        "screen_name" => screen_name,
        "count" => count,
        "include_rts" => include_rts?)
    end
  end
end
