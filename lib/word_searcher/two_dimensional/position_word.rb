module WordSearcher
  module TwoDimensional
    class PositionWord
      attr_accessor :plane, :word, :used_coordinates, :last_x, :last_y,
                    :current_direction
      delegate :x, :y, to: :plane
      delegate :length, to: :word

      def initialize(plane, word)
        @plane = plane
        @word = word
        @used_coordinates = []
      end

      def perform
        Direction.keys.shuffle.find do |direction|
          @current_direction = Direction.value(direction)
          @last_x = coordinate.x + length * current_direction.first
          @last_y = coordinate.y + length * current_direction.second
          valid?
        end

        place_word
      end

      def coordinate
        @coordinate ||= Point.new(random(plane.x), random(plane.y))
      end

      def valid?
        valid_coordinates? && no_overlaps?
      end

      private

      def random(number)
        SecureRandom.random_number number
      end

      def valid_coordinates?
        last_x >= 0 && last_y >= 0 && last_x < x && last_y < y
      end

      def no_overlaps?
        @no_overlaps = true
        letters = word.split('')
        letters.count.times do |position|
          letter = plane_letter(position)
          @no_overlaps = letter.blank? || letters[position] == letter
        end
      end

      def plane_letter(position)
        x_coord = coordinate.x + position * current_direction.first
        y_coord = coordinate.y + position * current_direction.second
        plane[x_coord][y_coord].letter
      end

      def place_word
        word.split('').each do |letter|
          plane[coordinate.x][coordinate.y].letter = letter
          coordinate.x += current_direction.first
          coordinate.y += current_direction.second
        end
      end
    end
  end
end
