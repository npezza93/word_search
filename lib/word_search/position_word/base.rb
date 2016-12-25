module WordSearch
  class PositionWord
    class Base
      attr_accessor :plane, :word, :direction, :coordinate, :positions

      def initialize(plane, word, direction, coordinate)
        @plane = plane
        @word = word
        @direction = direction
        @coordinate = coordinate
        @positions = {}
      end

      def perform
        return false unless valid?

        letters.each_with_index do |letter, index|
          place_letter(letter)
          document_position(letter, index)
          update_coordinates
        end

        write_solution
        true
      end

      def valid?
        valid_coordinates? && valid_letters?
      end

      def place_letter
        raise NotImplementedError
      end

      def update_coordinates
        raise NotImplementedError
      end

      def positive_last_coordinates?
        raise NotImplementedError
      end

      def last_coordinates_in_plane?
        raise NotImplementedError
      end

      def letter_at
        raise NotImplementedError
      end

      def document_position
        raise NotImplementedError
      end

      private

      def write_solution
        file_name = "solution_#{Digest::MD5.hexdigest(plane.to_s)}"
        File.open(file_name, "w") do |f|
          solution = positions.map do |letter, position|
            "#{letter.split('-')[0]} #{position.values}"
          end.join("\n")

          f.write solution
        end
      end

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
        @letters ||= word.split("")
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
