require_relative "../network/twitter_lib"
require_relative "./screen"
require_relative "./commands"

module Twitter
  class UserConsole
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

    private

    def commands
      [TimelineCommand.new, MentionsCommand.new, 
       RetweetsCommand.new, FriendsUpdateCommand.new, 
       ExitCommand.new, NotExistCommand.new]
    end

    def execute_command(command)
      commands.each do |cmd|
        return cmd.execute if cmd.match?(command)
      end
    end
  end
end
