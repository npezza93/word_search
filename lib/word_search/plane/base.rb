module WordSearch
  class Plane
    class Base < Hash
      include ActiveModel::Validations

      attr_accessor :x, :y, :catalog

      validates :x, :y, numericality: { greater_than_or_equal_to: 2 }

      def print(file_name = nil)
        File.open(file_name || "word_search", "w") { |f| f.write to_s }
      end

      def random_letter
        ("a".."z").to_a[SecureRandom.random_number(26)]
      end

      def two_dimensional?
        true
      end

      def three_dimensional?
        false
      end

      def add_letters
        x.times do |x_point|
          y.times do |y_point|
            yield(x_point, y_point)
          end
        end
      end

      def pto_s
        puts to_s
      end

      def digest
        Digest::MD5.hexdigest(to_s)
      end

      def to_s
        raise NotImplementedError
      end

      def total_points
        raise NotImplementedError
      end

      def max
        raise NotImplementedError
      end

      def directions
        raise NotImplementedError
      end

      private

      def initialize_plane
        x.times do |x_point|
          self[x_point] = {}
          y.times do |y_point|
            yield(x_point, y_point)
          end
        end
      end
    end
  end
end
