require_relative "../network/twitter_lib"
require_relative "../lib/tweet/parser"
require_relative "./screen"


module Twitter
  module Commands
    TIMELINE = "timeline"
    MENTIONS = "mention"
    RETWEETS = "rets"
    FRIENDS = "friends"
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
        break if tweets.nil?
        Screen.write_in_terminal(tweets) 
        @last_fetch = tweets
      end
      open_tweets_file_if_needed(@last_fetch) if !@last_fetch.nil?
    end

    def open_tweets_file_if_needed(tweets)
      puts "wanna open tweets file?!(y/n)"
      answer = gets.chop.downcase
      if answer == "y" || answer == "yes"
        Screen.open_in_vim tweets
      end
    end

    def latest_timeline(screen_name)
      timeline = TwitterLib.user_timeline(screen_name)
      @parser.get_tweets(timeline)
    end

    def friends_latest_tweets
      latest_tweets = TwitterLib.friends_latest_tweets
    end

    def latest_mentions
      mentions = TwitterLib.mentions_timeline
      @parser.get_tweets(mentions)
    end

    def latest_retweets
      retweets = TwitterLib.retweets
      @parser.get_tweets(retweets)
    end

    private

    def execute_command(command)
      case command
        when Commands::TIMELINE
          latest_timeline("masihjesus")
        when Commands::MENTIONS
          latest_mentions
        when Commands::RETWEETS
          latest_retweets
        when Commands::FRIENDS
          friends_latest_tweets
        when Commands::EXIT
          nil
        else
          puts valid_commands_message
          []
      end
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
