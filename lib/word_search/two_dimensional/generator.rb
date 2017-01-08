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

      def place_word(word)
        placed = false
        until placed || used_coordinates.uniq.count == plane.total_points
          placed = position_word(word)
        end

        word_bank.errors.add(word, "cannot be placed") if placed.blank?
        placed
      end

      def position_word(word)
        used_coordinates << (coordinate = random_point)
        position = false

        directions.find do |direction|
          position =
            PositionWord.new(plane, word, direction, coordinate).perform
        end

        position
      end

      def random_point
        Point.new(random(plane.x), random(plane.y))
      end
    end
  end
end
