module CrosswordPuzzler
  module TwoDimensional
    class Plane < Plane::Base
      def initialize(x, y)
        @x, @y = x, y

        @plane = {}

        x.times do |x_point|
          y.times do |y_point|
            @plane[x_point] ||= {}
            @plane[x_point][y_point] =
              Point.new(x_point, y_point)
          end
        end
      end

      def to_s
        plane.values.map do |row|
          row.values.map(&:to_s)
        end.transpose.reverse.map(&:join).join("\n")
      end

      def two_dimensional?
        true
      end

      def three_dimensional?
        false
      end
    end
  end
end
