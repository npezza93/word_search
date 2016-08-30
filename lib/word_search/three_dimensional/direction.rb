module WordSearch
  module ThreeDimensional
    class Direction
      include Ruby::Enum

      # Standard cardinal directions
      define :N,  [0,   1, 0]
      define :NE, [1,   1, 0]
      define :E,  [1,   0, 0]
      define :SE, [1,  -1, 0]
      define :S,  [0,  -1, 0]
      define :SW, [-1, -1, 0]
      define :W,  [-1,  0, 0]
      define :NW, [-1,  1, 0]

      # cardinal directions with a positive z index (forward)
      define :NF,   [0,   1, 1]
      define :NEF,  [1,   1, 1]
      define :EF,   [1,   0, 1]
      define :SEF,  [1,  -1, 1]
      define :SF,   [0,  -1, 1]
      define :SWF,  [-1, -1, 1]
      define :WF,   [-1,  0, 1]
      define :NWF,  [-1,  1, 1]

      # cardinal directions with a negative z index (back)
      define :NB,   [0,   1, -1]
      define :NEB,  [1,   1, -1]
      define :EB,   [1,   0, -1]
      define :SEB,  [1,  -1, -1]
      define :SB,   [0,  -1, -1]
      define :SWB,  [-1, -1, -1]
      define :WB,   [-1,  0, -1]
      define :NWB,  [-1,  1, -1]
    end
  end
end
