module CrosswordPuzzler
  class Plane < SimpleDelegator
    def initialize(x, y, z = nil)
      obj =
        if z.present?
          ThreeDimensional::Plane.new(x, y, z)
        else
          TwoDimensional::Plane.new(x, y)
        end
      super obj
    end

    def to_s
      if invalid?
        puts errors.full_messages.join("\n")
      else
        super
      end
    end
  end
end
