module Twitter
  module Commands
    AUTHENTICATE = "auth"
    TIMELINE = "timeline"
    MENTIONS = "mention"
    RETWEETS = "rets"
    FRIENDS = "friends"
    EXIT = "exit"
  end

  class AuthenticateCommand
    def match?(command)
      command == Commands::AUTHENTICATE
    end

    def execute
      puts TwitterLib.authenticate
      nil
    end
  end

  class TimelineCommand
    def match?(command)
      command == Commands::TIMELINE
    end

    def execute
      TwitterLib.user_timeline("masihjesus")
    end
  end

  class MentionsCommand
    def match?(command)
      command == Commands::MENTIONS
    end

    def execute
      TwitterLib.mentions_timeline
    end
  end

  class RetweetsCommand
    def match?(command)
      command == Commands::RETWEETS
    end

    def execute
      TwitterLib.retweets
    end
  end

  class FriendsUpdateCommand
    def match?(command)
      command == Commands::FRIENDS
    end

    def execute
      TwitterLib.friends_latest_tweets
    end
  end

  class ExitCommand
    def match?(command)
      command == Commands::EXIT
    end

    def execute
      nil
    end
  end

  class NotExistCommand
    def match?(command)
      true
    end

    def execute
      puts valid_commands_message
      []
    end

    private

    def valid_commands_message
      %Q{
          Valid commands are:
            "timeline" --> tweet timeline
            "mentions" --> your mentions
            "rets"     --> your retweets
            "friends"  --> last tweet of your friends
      }
    end
  end
end
