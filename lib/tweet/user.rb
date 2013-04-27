module Twitter
  class User
    attr_reader :id, :screen_name

    def initialize(id, screen_name)
      @id = id
      @screen_name = screen_name
    end
  end
end
