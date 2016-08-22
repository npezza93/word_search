module CrosswordPuzzler
  module ThreeDimensional
    class Point
      attr_accessor :x, :y, :z, :letter
      alias to_s letter

      def initialize(x, y, z, letter = nil)
        @x = x
        @y = y
        @z = z
        @letter = letter || ('a'..'z').to_a[rand(26)]
      end
    end
  end
end
