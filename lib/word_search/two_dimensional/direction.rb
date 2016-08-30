module WordSearch
  module TwoDimensional
    class Direction
      include Ruby::Enum

      # Standard cardinal directions
      define :N,  [0,   1]
      define :NE, [1,   1]
      define :E,  [1,   0]
      define :SE, [1,  -1]
      define :S,  [0,  -1]
      define :SW, [-1, -1]
      define :W,  [-1,  0]
      define :NW, [-1,  1]
    end
  end
end
