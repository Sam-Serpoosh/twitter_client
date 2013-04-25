require_relative "./network/twitter_lib"
require_relative "./lib/tweet/parser"
require_relative "./screen"


module Twitter
  module Commands
    TIMELINE = "timeline"
    MENTIONS = "mention"
    RETWEETS = "rets"
    EXIT = "exit"
  end
end

module Twitter
  class UserConsole
    def initialize
      @parser = Parser.new
    end

    def run
      while true
        command = gets.chop
        tweets = execute_command command
        Screen.write_in_terminal(tweets) if !tweets.nil?
      end
    end

    private

    def execute_command(command)
      case command
        when Commands::TIMELINE
          return latest_timeline
        when Commands::MENTIONS
          return latest_mentions
        when Commands::RETWEETS
          return latest_retweets
        when Commands::EXIT
          exit
        else
          puts valid_commands_message
          return nil
      end
    end

    def latest_timeline
      timeline = TwitterLib.user_timeline
      @parser.get_tweets(timeline)
    end

    def latest_mentions
      mentions = TwitterLib.mentions_timeline
      @parser.get_tweets(mentions)
    end

    def latest_retweets
      retweets = TwitterLib.retweets
      @parser.get_tweets(retweets)
    end
    
    def valid_commands_message
      %Q{
          Valid commands are:
            "timeline" --> tweet timeline
            "mentions" --> your mentions
            "rets"     --> your retweets
      }
    end
  end
end


Twitter::UserConsole.new.run