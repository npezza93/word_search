module WordSearch
  class PositionWord
    class Base
      attr_accessor :plane, :word, :direction, :coordinate

      def initialize(plane, word, direction, coordinate)
        @plane = plane
        @word = word
        @direction = direction
        @coordinate = coordinate
      end

      def perform
        return false unless valid?

        word.split('').each do |letter|
          place_letter(letter)
          update_coordinates
        end
      end

      def valid?
        valid_coordinates? && valid_letters?
      end

      private

      def last_x
        return @last_x if defined? @last_x

        @last_x = coordinate.x
        (word.length - 1).times do
          @last_x += direction.x
        end

        @last_x
      end

      def last_y
        return @last_y if defined? @last_y

        @last_y = coordinate.y
        (word.length - 1).times do
          @last_y += direction.y
        end

        @last_y
      end

      def last_z
        return @last_z if defined? @last_z

        @last_z = coordinate.z
        (word.length - 1).times do
          @last_z += direction.z
        end

        @last_z
      end

      def valid_coordinates?
        positive_last_coordinates? && last_coordinates_in_plane?
      end

      def valid_letters?
        bad_overlap, intersection_points = false, 0

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

      def letters
        @letters ||= word.split('')
      end

      def x_at(position)
        coordinate.x + position * direction.x
      end

      def y_at(position)
        coordinate.y + position * direction.y
      end

      def z_at(position)
        coordinate.z + position * direction.z
      end
    end
  end
end
