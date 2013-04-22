module Twitter
  class Mention
    attr_reader :count

    def initialize(count = 20)
      @count = count
    end

    def api_path
      "1.1/statuses/mentions_timeline.json"
    end
  end
end
