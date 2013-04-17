require_relative "./network/twitter_http"
require_relative "./business_logic/parser"


module Twitter
  class UserConsole
    def initialize
      @parser = Parser.new
    end

    def latest_timeline(count_limit = 20)
      timeline = Http.user_timeline(count_limit)
      @parser.get_tweets(timeline)
    end

    def latest_mentions(count_limit = 20)
      mentions = Http.mentions_timeline(count_limit)
      @parser.get_tweets(mentions)
    end

    def latest_retweets(count_limit = 20)
      retweets = Http.retweets(count_limit)
      @parser.get_tweets(retweets)
    end
  end
end

module Twitter
  class Format
    BOUNDARY = "-" * 80

    def self.timeline(tweets)
      tweets.each do |t|
        puts BOUNDARY 
        puts t
        puts BOUNDARY 
      end
    end
  end
end

console = Twitter::UserConsole.new
Twitter::Format.timeline(console.latest_retweets)