require_relative "../../network/twitter_network"

module Twitter
  class Retweet
    attr_reader :count, :query

    def initialize(count = 20)
      @count = count
      set_query
    end

    def api_path
      "1.1/statuses/retweets_of_me.json"
    end

    private
    
    def set_query
      @query = Network.create_query("count" => count)
    end
  end
end
