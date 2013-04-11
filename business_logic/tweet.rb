require_relative "./tweet_formatter"

module Twitter
  class Tweet
    attr_reader :screen_name, :text

    def initialize(screen_name, text)
      @screen_name = screen_name
      @text = text
    end

    def to_s
      "@#{screen_name}:\n#{TweetFormatter.format(text)}"
    end
  end
end
