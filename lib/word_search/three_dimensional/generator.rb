# frozen_string_literal: true

module WordSearch
  module ThreeDimensional
    class Generator < Generator::Base
      def directions
        Direction.values.shuffle.map do |direction|
          Point.new(direction.first, direction.second, direction.third)
        end
      end

      private

      def random_point
        Point.new(random(plane.x), random(plane.y), random(plane.z))
      end
    end
  end
end
