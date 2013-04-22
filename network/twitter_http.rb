require_relative "./twitter_network"
require_relative "../tweet_lib/timeline"
require_relative "../tweet_lib/mention"

module Twitter
  module Lib
    def self.authenticate
      path = "1.1/account/verify_credentials.json"
      Network.fetch_response(path)
    end

    def self.user_timeline
      timeline = Timeline.new(Network::SCREEN_NAME, 20)
      query = Network.create_query(
        "screen_name" => timeline.screen_name,
        "count" => timeline.count,
        "include_rts" => timeline.include_rts?)
      Network.fetch_response(timeline.path, query)
    end

    def self.mentions_timeline
      mention = Mention.new
      query = Network.create_query("count" => mention.count)
      Network.fetch_response(mention.api_path, query)
    end

    def self.retweets(count_limit)
      path = "1.1/statuses/retweets_of_me.json"
      query = Network.create_query("count" => count_limit)
      Network.fetch_response(path, query)
    end
  end
end
