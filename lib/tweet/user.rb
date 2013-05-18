module Twitter
  class User
    attr_reader :id, :screen_name, :friends

    def initialize(id=nil, screen_name)
      @id = id
      @screen_name = screen_name
      @friends = []
    end

    def add_friends(friends)
      @friends += friends
    end

    def to_s
      "#{id} - #{screen_name}"
    end
  end
end
