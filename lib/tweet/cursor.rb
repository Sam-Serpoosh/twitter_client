module Twitter
  class Cursor
    attr_reader :previous_cursor, :next_cursor

    def initialize(previous_cursor, next_cursor)
      @previous_cursor = previous_cursor
      @next_cursor = next_cursor
    end

    def has_next?
      !next_cursor.nil? && next_cursor != 0
    end
  end
end
