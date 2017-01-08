# frozen_string_literal: true
module WordSearch
  class Generator
    class Base
      include ActiveModel::Validations

      attr_accessor :plane, :word_bank, :used_coordinates, :positions
      delegate :to_s, :pto_s, :print, :catalog, to: :plane

      def directions
        raise NotImplementedError
      end

      def initialize(plane, word_bank)
        @plane = plane
        @word_bank = word_bank
        @used_coordinates = []
        @positions = {}
      end

      def perform
        word_bank.each do |word|
          @positions[word] = place_word(word)
        end
      end

      def write_solution
        file_name = "solution_#{plane.digest}"
        File.open(file_name, "w") do |f|
          solution = positions.map do |_word, letter_positions|
            letter_positions.map do |letter, position|
              "#{letter.split('-')[0]} #{position.values}"
            end.join("\n")
          end.join("\n---\n")

          f.write solution
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

      def random(number)
        SecureRandom.random_number number
      end

      def place_word
        raise NotImplementedError
      end

      def position_word
        raise NotImplementedError
      end

      def random_point
        raise NotImplementedError
      end
    end
  end
end
