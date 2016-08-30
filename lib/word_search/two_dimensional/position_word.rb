module WordSearch
  module TwoDimensional
    class PositionWord
      attr_accessor :plane, :word, :direction, :coordinate

      def initialize(plane, word, direction, coordinate)
        @plane = plane
        @word = word
        @direction = direction
        @coordinate = coordinate
      end

      def last_x
        @last_x = coordinate.x
        (word.length - 1).times do
          @last_x += direction.x
        end

        @last_x
      end

      def last_y
        @last_y = coordinate.y
        (word.length - 1).times do
          @last_y += direction.y
        end

        @last_y
      end

      def perform
        return false unless valid?

        word.split('').each do |letter|
          place_letter(letter)
          coordinate.x += direction.x
          coordinate.y += direction.y
        end
      end

      def valid?
        valid_coordinates? && valid_letters?
      end

      private

      def place_letter(letter)
        plane[coordinate.x][coordinate.y].letter = letter
      end

      def letters
        @letters ||= word.split('')
      end

      def valid_coordinates?
        last_x >= 0 && last_y >= 0 && last_x < plane.x && last_y < plane.y
      end

      def valid_letters?
        bad_overlap = false
        intersection_points = 0
        letters.count.times do |position|
          next if letter_at(position).blank?

          if letters[position] == letter_at(position)
            intersection_points += 1
          else
            bad_overlap = true
          end
        end

        !bad_overlap && intersection_points < 2
      end

      def letter_at(position)
        plane.dig(
          coordinate.x + position * direction.x,
          coordinate.y + position * direction.y
        ).letter
      end
    end
  end
end
