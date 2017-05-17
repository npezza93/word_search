# frozen_string_literal: true

module WordSearch
  class Plane < SimpleDelegator
    def self.make_from_file(file, should_catalog: true)
      dimension =
        if File.read(file).split("\n\n").count > 1
          ThreeDimensional
        else
          TwoDimensional
        end

      obj =
        dimension::Plane.make_from_file(file, should_catalog: should_catalog)

      new(obj)
    end

    def self.make_from_coordinates(x, y, z = nil)
      obj =
        if z.present? && z > 1
          ThreeDimensional::Plane.new(x, y, z)
        else
          TwoDimensional::Plane.new(x, y)
        end

      new(obj)
    end

    def to_s
      if invalid?
        errors.full_messages.join("\n")
      else
        super
      end
    end
  end
end
