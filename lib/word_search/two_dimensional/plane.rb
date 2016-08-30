module WordSearch
  module TwoDimensional
    class Plane < Plane::Base
      def initialize(x, y)
        @x, @y = x, y

        initialize_plane do |x_point, y_point|
          self[x_point][y_point] = Point.new(x_point, y_point)
        end
      end

      def to_s
        values.map do |row|
          row.values.map(&:letter)
        end.transpose.reverse.map(&:join).join("\n")
      end

      def add_letters
        super do |x_point, y_point|
          self[x_point][y_point].letter ||= random_letter
        end
      end

      def total_points
        x * y
      end

      def max
        [x, y].max
      end

      class << self
        def make_from_file(file)
          string = File.read(file).split("\n").reverse

          return false if string.collect(&:length).uniq.count > 1

          make_word_search(string)
        end

        private

        def make_word_search(string)
          plane = new(string.collect(&:length).uniq.first, string.count)

          string.each_with_index do |row, y|
            row.split('').each_with_index do |letter, x|
              plane[x][y] = Point.new(x, y, letter)
            end
          end

          plane
        end
      end
    end
  end
end
