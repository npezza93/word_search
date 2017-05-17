# frozen_string_literal: true

module WordSearch
  module ThreeDimensional
    class PositionWord < PositionWord::Base
      private

      def place_letter(letter)
        plane[coordinate.x][coordinate.y][coordinate.z].letter = letter
      end

      def update_coordinates
        coordinate.x += direction.x
        coordinate.y += direction.y
        coordinate.z += direction.z
      end

      def positive_last_coordinates?
        last_x >= 0 && last_y >= 0 && last_z >= 0
      end

      def last_coordinates_in_plane?
        last_x < plane.x && last_y < plane.y && last_z < plane.z
      end

      def letter_at(position)
        plane.dig(x_at(position), y_at(position), z_at(position)).letter
      end

      def document_position(letter, index)
        positions.merge!("#{letter}-#{index}" => {
          x: coordinate.x, y: coordinate.y, z: coordinate.z
        })
      end
    end
  end
end
