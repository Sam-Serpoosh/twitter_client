require_relative "../../network/twitter_network"

module Twitter
  class Mention
    attr_reader :count, :query

    def initialize(count = 20)
      @count = count
      set_query
    end

    def api_path
      "1.1/statuses/mentions_timeline.json"
    end

    private
    
    def set_query
      @query = Network.create_query("count" => count)
    end
  end
end
