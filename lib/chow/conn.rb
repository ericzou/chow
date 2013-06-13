module Chow
  class Conn
    class << self
      attr_accessor :connection

      def connection=(connection)
        @connection = connection
      end

      def execute(s, *args)

      end

    end

  end
end


# locator.locate('move_user')

# -> queries.find('')