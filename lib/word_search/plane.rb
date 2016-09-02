module WordSearch
  class Plane < SimpleDelegator
    def self.make_from_file(file)
      obj =
        if File.read(file).split("\n\n").count > 1
          ThreeDimensional::Plane.make_from_file(file)
        else
          TwoDimensional::Plane.make_from_file(file)
        end

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
