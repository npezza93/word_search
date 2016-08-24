module WordSearcher
  module TwoDimensional
    class Point
      attr_accessor :x, :y, :letter
      alias to_s letter

      def initialize(x, y)
        @x = x
        @y = y
      end
    end
  end
end
