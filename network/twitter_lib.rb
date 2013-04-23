require_relative "./twitter_network"
require_relative "../lib/tweet/timeline"
require_relative "../lib/tweet/mention"
require_relative "../lib/tweet/retweet"

module Twitter
  module TwitterLib
    def self.authenticate
      path = "1.1/account/verify_credentials.json"
      Network.fetch_response(path)
    end

    def self.user_timeline
      timeline = Timeline.new(Network::SCREEN_NAME)
      query = Network.create_query(
        "screen_name" => timeline.screen_name,
        "count" => timeline.count,
        "include_rts" => timeline.include_rts?)
      Network.fetch_response(timeline.api_path, query)
    end

    def self.mentions_timeline
      mention = Mention.new
      query = Network.create_query("count" => mention.count)
      Network.fetch_response(mention.api_path, query)
    end

    def self.retweets
      rt = Retweet.new
      query = Network.create_query("count" => rt.count)
      Network.fetch_response(rt.api_path, query)
    end
  end
end
