module CrosswordPuzzler
  class Plane
    class Base
      include ActiveModel::Validations

      attr_accessor :x, :y, :plane
      delegate :[], to: :plane

      validates :x, :y, numericality: { greater_than_or_equal_to: 2 }

      def print(file_name = nil)
        File.open(file_name || 'crossword', 'w') { |f| f.write to_s }
      end
    end
  end
end
