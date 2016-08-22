module CrosswordPuzzler
  module TwoDimensional
    class Point
      attr_accessor :x, :y, :letter
      alias to_s letter

      def initialize(x, y, letter = nil)
        @x = x
        @y = y
        @letter = letter || ('a'..'z').to_a[rand(26)]
      end
    end
  end
end
