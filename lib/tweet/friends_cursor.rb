module Twitter
  class FriendsCursor
    attr_reader :previous_cursor, :next_cursor, :users_data

    def initialize(previous_cursor, next_cursor, users_data)
      @previous_cursor = previous_cursor
      @next_cursor = next_cursor
      @users_data = users_data
    end

    def last?
      next_cursor == 0 || next_cursor.nil?
    end
  end
end
