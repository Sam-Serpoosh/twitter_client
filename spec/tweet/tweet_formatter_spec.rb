require_relative "../../lib/tweet/tweet_formatter"

module Twitter
  describe TweetFormatter do
    it "does not break a text when there is not space in it" do
      long_text = "a" * 140
      TweetFormatter.format(long_text).should == long_text
    end

    it "does not break a text when space is after screen width" do
      long_text = ("a" * TweetFormatter::SCREEN_WIDTH_NEW) + " " + ("b" * 20)
      TweetFormatter.format(long_text).should == long_text
    end

    it "does not break a text when it is less than screen width long" do
      short_text = "foo" + " " + ("a" * (TweetFormatter::SCREEN_WIDTH_NEW / 10)) 
      TweetFormatter.format(short_text).should == short_text
    end

    it "does not break text when space is before half of screen width" do
      long_text = "a" * 130
      long_text[TweetFormatter::SCREEN_WIDTH_NEW / 2] = " "
      TweetFormatter.format(long_text).should == long_text
    end

    it "replaces the last space before screen width with line-break" do
      long_text = ("a" * 40) + " " + ("b" * 37) + " " + ("b" * 50)
      formatted = TweetFormatter.format long_text
      formatted.should == ("a" * 40) + " " + ("b" * 37) + "\n" + ("b" * 50)
    end
  end
end
