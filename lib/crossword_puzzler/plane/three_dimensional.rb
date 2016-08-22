module CrosswordPuzzler
  class Plane
    class ThreeDimensional < Base
      attr_accessor :z
      validates :z, numericality: { greater_than_or_equal_to: 1 }

      def initialize(x, y, z)
        @x, @y, @z = x, y, z

        @plane = {}

        x.times do |x_point|
          y.times do |y_point|
            @plane[x_point] ||= {}
            @plane[x_point][y_point] ||= {}
            z.times do |z_point|
              @plane[x_point][y_point][z_point] =
                Point.new(x_point, y_point, z_point)
            end
          end
        end
      end

      def to_s
        (0..(z - 1)).map do |z_slice|
          plane.values.map do |row|
            row.values.map { |ys| ys[z_slice] }.map(&:to_s)
          end.transpose.reverse.map(&:join).join("\n")
        end.join("\n\n")
      end

      def two_dimensional?
        true
      end

      def three_dimensional?
        true
      end
    end
  end
end
