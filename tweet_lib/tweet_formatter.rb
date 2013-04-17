module Twitter
  class TweetFormatter
    SCREEN_WIDTH_NEW = 80

    def self.format(tweet)
      cloned = tweet.clone
      return cloned if cloned.length < SCREEN_WIDTH_NEW
      space_index = first_space_before_screen_width cloned
      cloned[space_index] = "\n" if space_index != -1
      cloned
    end

    private

    def self.first_space_before_screen_width(tweet)
      idx = SCREEN_WIDTH_NEW - 1
      while idx >= 0 && tweet[idx] != " "
        idx -= 1
      end
      idx <= SCREEN_WIDTH_NEW / 2 ? -1 : idx
    end
  end
end
