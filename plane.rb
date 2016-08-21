require 'active_model'
load 'point.rb'

class Plane
  include ActiveModel::Validations

  attr_accessor :x, :y, :z, :plane

  validates :x, :y, numericality: { greater_than_or_equal_to: 2 }
  validates :z, numericality: { greater_than_or_equal_to: 1 }

  delegate :[], to: :plane

  def initialize(x, y, z = 1)
    @x, @y, @z = x, y, z

    @plane = {}

    x.times do |x_point|
      y.times do |y_point|
        @plane[x_point] ||= {}
        build_point(x_point, y_point)
      end
    end
  end

  def two_dimenisional?
    x && y
  end

  def three_dimensional?
    two_dimenisions? && z > 1
  end

  def to_s
    plane.values.map do |row|
      row.values.map(&:to_s)
    end.transpose.reverse.map(&:join).join("\n")
  end

  def print(file_name = nil)
    File.open(file_name || 'crossword', 'w') { |f| f.write to_s }
  end

  private

  def build_point(x_point, y_point)
    if z > 1
      @plane[x_point][y_point] ||= {}
      z.times do |z_point|
        @plane[x_point][y_point][z_point] = Point.new(x_point, y_point, z_point)
      end
    else
      @plane[x_point][y_point] = Point.new(x_point, y_point)
    end
  end
end
