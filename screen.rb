module Twitter
  class Screen
    BOUNDARY = "-" * 80
    END_OF_SCREEN = "#{"*" * 80}\nFINISHED!"

    def self.write_in_terminal(tweets)
      puts prepare_to_render tweets
    end

    private

    def self.prepare_to_render(tweets)
      result = ""
      tweets.each do |t|
        result += BOUNDARY + "\n"
        result += t.to_s + "\n"
        result += BOUNDARY + "\n"
      end
      result += END_OF_SCREEN + "\n"
      result
    end
  end
end
