require_relative "./tweet_formatter"

module Twitter
  class Tweet < Struct.new(:id, :screen_name, :text)
    def initialize(id, screen_name, text)
      super(id, screen_name, text)
    end

    def to_s
      "@#{screen_name}:\n#{TweetFormatter.format(text)}"
    end

    def line_count
      text.split("\n").count
    end
  end
end
