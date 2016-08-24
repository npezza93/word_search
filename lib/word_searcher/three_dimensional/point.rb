module WordSearcher
  module ThreeDimensional
    class Point
      attr_accessor :x, :y, :z, :letter
      alias to_s letter

      def initialize(x, y, z, letter = nil)
        @x = x
        @y = y
        @z = z
        @letter = '_'
      end
    end
  end
end
