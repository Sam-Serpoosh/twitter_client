require_relative "../network/twitter_network"

module Twitter
  class Retweet
    attr_reader :count, :query

    def initialize(options = {})
      @count = options[:count] || 20
      @network = options[:network] || Network
      set_query
    end

    def api_path
      "1.1/statuses/retweets_of_me.json"
    end

    def fetch_retweets
      @network.fetch_response(api_path, query)
    end

    private
    
    def set_query
      @query = @network.create_query("count" => count)
    end
  end
end
