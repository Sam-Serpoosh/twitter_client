require 'colorize'
require_relative "./tweet_formatter"

module Twitter
  class Tweet < Struct.new(:id, :screen_name, :text)
    def to_s
      "@#{screen_name.green}:\n#{TweetFormatter.format(text)}"
    end

    def line_count
      text.split("\n").count
    end

    def empty?
      text.length == 0
    end
  end
end
