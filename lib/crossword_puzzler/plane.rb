module CrosswordPuzzler
  class Plane < SimpleDelegator
    def initialize(x, y, z = nil)
      obj =
        if z.present?
          ThreeDimensional.new(x, y, z)
        else
          TwoDimensional.new(x, y)
        end
      super obj
    end
  end
end
