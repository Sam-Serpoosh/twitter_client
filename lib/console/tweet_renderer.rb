require 'colorize'

module Twitter
  class TweetRenderer
    BOUNDARY = ("-" * 80).red
    END_OF_SCREEN = "#{"*" * 80}\nFINISHED!".yellow
    DIR = File.join(Dir.home, "DailyTweets")
    TWEETS_PATH = "#{DIR}/tweets"

    def self.write_in_terminal(tweets)
      puts prepare_to_render(tweets)
    end

    def self.open_in_vim(tweets)
      create_tweets_directory
      File.open(TWEETS_PATH, "w") do |f|
        f.write(prepare_to_render(tweets))
      end 
      system("mvim #{TWEETS_PATH}")
    end

    def self.create_tweets_directory
      Dir::mkdir(DIR) if !Dir::exist?(DIR)
    end

    private

    def self.prepare_to_render(tweets)
      result = ""
      tweets.each do |t|
        next if t.empty?
        result += BOUNDARY + "\n"
        result += t.to_s + "\n"
        result += BOUNDARY + "\n"
      end
      result += END_OF_SCREEN + "\n"
      result
    end
  end
end
