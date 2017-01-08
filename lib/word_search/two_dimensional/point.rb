# frozen_string_literal: true
module WordSearch
  module TwoDimensional
    class Point
      attr_accessor :x, :y, :letter
      alias to_s letter

      def initialize(x, y, letter = nil)
        @x = x
        @y = y
        @letter = letter if letter
      end

      def coordinate
        [x, y]
      end
    end
  end
end
