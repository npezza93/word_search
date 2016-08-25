module WordSearcher
  module TwoDimensional
    class Generator
      attr_accessor :plane, :words

      def initialize(plane, words)
        @plane = plane
        @words = words
      end

      def perform
        words.each do |word|
          PositionWord.new(plane, word).perform
        end
        plane.add_letters
        plane
      end

      def select_direction
        Direction.value(Direction.keys[random(Direction.count)])
      end

      def select_coordinates
        Point.new(random(plane.x), random(plane.y))
      end

      private

      def random(number)
        SecureRandom.random_number number
      end
    end
  end
end
