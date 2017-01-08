# frozen_string_literal: true
module WordSearch
  module TwoDimensional
    class Generator < Generator::Base
      def directions
        Direction.values.shuffle.map do |direction|
          Point.new(direction.first, direction.second)
        end
      end

      private

      def random_point
        Point.new(random(plane.x), random(plane.y))
      end
    end
  end
end
