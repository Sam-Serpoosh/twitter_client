module Twitter
  class FriendsCursor
    attr_reader :previous_cursor, :next_cursor

    def initialize(previous_cursor, next_cursor)
      @previous_cursor = previous_cursor
      @next_cursor = next_cursor
    end

    def last?
      next_cursor == 0 || next_cursor.nil?
    end
  end
end
