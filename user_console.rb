require_relative "./network/twitter_http"
require_relative "./business_logic/parser"


module Twitter
  class UserConsole
    def latest_timeline
      parser = Parser.new
      timeline = Http.user_timeline.body
      tweets = parser.get_tweets(timeline)
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
Twitter::Format.timeline(console.latest_timeline)