require_relative "./twitter_network"
require_relative "./settings"
require_relative "../tweet/authenticate"
require_relative "../tweet/timeline"
require_relative "../tweet/mention"
require_relative "../tweet/retweet"
require_relative "../tweet/parser"
require_relative "../tweet/following"
require_relative "../tweet/cursor"

module Twitter
  module TwitterLib
    def self.authenticate
      authenticate = Authenticate.new
      response = Network.fetch_response(authenticate.api_path)
      Parser.new.authentication_result(response)
    end

    def self.user_timeline(screen_name, count = 20)
      timeline = Timeline.new(screen_name, count: count)
			response = timeline.fetch_timeline
      get_tweets response
    end

    def self.mentions_timeline
      mention = Mention.new
      response = mention.fetch_mentions
      get_tweets response
    end

    def self.retweets
      rt = Retweet.new
      response = rt.fetch_retweets
      get_tweets response
    end

    def self.friends
      following = Following.new(Settings::SCREEN_NAME)
      following.friends
    end

    def self.friends_latest_tweets
      following = Following.new(Settings::SCREEN_NAME)
      following.friends_latest_tweets
    end

    private

    def self.get_tweets(response)
      Parser.new.get_tweets response
    end
  end
end
