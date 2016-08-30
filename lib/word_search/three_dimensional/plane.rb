module WordSearch
  module ThreeDimensional
    class Plane < Plane::Base
      attr_accessor :z
      validates :z, numericality: { greater_than_or_equal_to: 1 }

      def initialize(x, y, z)
        @x, @y, @z = x, y, z

        initialize_plane do |x_point, y_point|
          self[x_point][y_point] = {}
          z.times do |z_point|
            self[x_point][y_point][z_point] =
              Point.new(x_point, y_point, z_point)
          end
        end
      end

      def to_s
        (0..(z - 1)).map do |z_slice|
          values.map do |row|
            row.values.map { |ys| ys[z_slice] }.map(&:to_s)
          end.transpose.reverse.map(&:join).join("\n")
        end.join("\n\n")
      end

      def three_dimensional?
        true
      end

      def total_points
        x * y * z
      end

      def max
        [x, y, z].max
      end

      def add_letters
        super do |x_point, y_point|
          z.times do |z_point|
            self[x_point][y_point][z_point].letter ||= random_letter
          end
        end
      end

      class << self
        def make_from_file(file)
          string = File.read(file).split("\n\n").map(&:split)

          return false unless valid_file?(string)

          make_word_search(string)
        end

        private

        def valid_file?(string)
          string.collect(&:length).uniq.count == 1 &&
            string.flat_map { |row| row.map(&:length) }.uniq.count == 1
        end

        def make_word_search(string)
          plane = empty_3d_plane_from_string(string)

          string.each_with_index do |slice, z|
            slice.reverse.each_with_index do |row, y|
              row.split('').each_with_index do |letter, x|
                plane[x][y][z] = Point.new(x, y, z, letter)
              end
            end
          end

          plane
        end

        def empty_3d_plane_from_string(string)
          x = string.flat_map { |row| row.map(&:length) }.uniq.first
          y = string.collect(&:length).uniq.first
          new(x, y, string.count)
        end
      end
    end
  end
end
