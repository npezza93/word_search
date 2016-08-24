module WordSearcher
  module TwoDimensional
    class PositionWord
      include ActiveModel::Validations

      attr_accessor :plane, :word
      delegate :x, :y, to: :plane
      delegate :length, to: :word

      validate :negative_coordinates?
      validate :coordinates_outside_plane?
      validate :overlaps?

      def initialize(plane, word)
        @plane = plane
        @word = word
      end

      def perform
        return false unless valid?

        word.split('').each do |letter|
          plane[coordinate.x][coordinate.y].letter = letter
          coordinate.x += direction.first
          coordinate.y += direction.second
        end
      end

      def direction
        @direction ||= Direction.value(Direction.keys[random(Direction.count)])
      end

      def coordinate
        @coordinate ||= Point.new(random(plane.x), random(plane.y))
      end

      def last_x
        coordinate.x + length * direction.first
      end

      def last_y
        coordinate.y + length * direction.second
      end

      private

      def random(number)
        SecureRandom.random_number number
      end

      def negative_coordinates?
        errors.add(:last_x, 'must be greater than 0') unless last_x > 0
        errors.add(:last_y, 'must be greater than 0') unless last_y > 0

        errors.messages.any?
      end

      def coordinates_outside_plane?
        errors.add(:last_x, "must be less than or equal to #{x}") if last_x > x
        errors.add(:last_y, "must be less than or equal to #{y}") if last_y > y

        errors.messages.any?
      end

      def overlaps?
        return false if negative_coordinates? || coordinates_outside_plane?

        temp_coord_x = coordinate.x
        temp_coord_y = coordinate.y

        word.split('').each do |letter|
          break if letter_conflict?(letter, temp_coord_x, temp_coord_y)
          temp_coord_x += direction.first
          temp_coord_y += direction.second
        end
      end

      def letter_conflict?(letter, temp_x, temp_y)
        placed_letter = plane[temp_x][temp_y].letter
        if placed_letter.present? && placed_letter != letter
          return errors.add(:base, 'Words overlap incorrectly')
        end

        errors.messages.any?
      end
    end
  end
end
