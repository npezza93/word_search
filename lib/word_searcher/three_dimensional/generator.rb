module WordSearcher
  module ThreeDimensional
    class Generator

      def directions
        {
          n:  [0, 1, 0],
          ne: [1, 1, 0],
          e:  [1, 0, 0],
          se: [1, -1, 0],
          s:  [0, -1, 0],
          sw: [-1, -1, 0],
          w:  [-1, 0, 0],
          nw: [-1, 1, 0],
          nf:  [1, 1, 1],
        }
      end
    end
  end
end
