require_relative "./twitter_network"

module Twitter
  module Http
    def self.verify_user
      path = "1.1/account/verify_credentials.json"
      execute_request(path)
    end

    def self.user_timeline(count_limit)
      path = "1.1/statuses/user_timeline.json"
      query = Twitter::Network.create_query(
        "screen_name" => Twitter::Network::SCREEN_NAME,
        "count" => count_limit,
        "include_rts" => 1)
      execute_request(path, query)
    end

    def self.mentions_timeline(count_limit)
      path = "1.1/statuses/mentions_timeline.json"
      query = Twitter::Network.create_query("count" => count_limit)
      execute_request(path, query)
    end

    def self.retweets(count_limit)
      path = "1.1/statuses/retweets_of_me.json"
      query = Twitter::Network.create_query("count" => count_limit)
      execute_request(path, query)
    end

    private 

    def self.execute_request(path, query = nil)
      address = Twitter::Network.create_address(path, query)
      http = Twitter::Network.create_http(address)
      request = Twitter::Network.create_authorized_request(http, address)
      response = Twitter::Network.execute_http(http, request)
      response
    end
  end
end
