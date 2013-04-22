module Twitter
  class Timeline
    attr_reader :screen_name, :count

    def initialize(screen_name, count = 20)
      @screen_name = screen_name
      @count = count
    end

    def include_rts?
      1
    end

    def api_path
      "1.1/statuses/user_timeline.json"
    end
  end
end
