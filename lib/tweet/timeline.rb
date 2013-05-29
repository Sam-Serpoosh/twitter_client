require_relative "../../network/twitter_network"

module Twitter
  class Timeline
    attr_reader :screen_name, :count, :query

    def initialize(screen_name, options = {})
      @screen_name = screen_name
      @count = options[:count] || 20
      @network = options[:network] || Network
      set_query
    end

    def include_rts?
      1
    end

    def api_path
      "1.1/statuses/user_timeline.json"
    end

    def fetch_response
      @network.fetch_response(api_path, query)
    end

    private

    def set_query
      @query = @network.create_query(
        "screen_name" => screen_name,
        "count" => count,
        "include_rts" => include_rts?)
    end
  end
end
