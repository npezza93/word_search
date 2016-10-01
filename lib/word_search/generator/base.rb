module WordSearch
  class Generator
    class Base
      include ActiveModel::Validations

      attr_accessor :plane, :word_bank, :used_coordinates
      delegate :to_s, :pto_s, :print, :catalog, to: :plane

      def initialize(plane, word_bank)
        @plane = plane
        @word_bank = word_bank
        @used_coordinates = []
      end

      def perform
        word_bank.each do |word|
          place_word(word)
        end
      end

      private

      def random(number)
        SecureRandom.random_number number
      end
    end
  end
end
