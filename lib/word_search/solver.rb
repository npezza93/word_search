module WordSearch
  class Solver
    attr_accessor :script, :word_bank, :plane

    def initialize(script, word_list_file, plane_file)
      @script = script
      @word_bank = WordBank.new(word_list_file)
      @plane = TwoDimensional::Plane.make_from_file(plane_file)
    end

    def execute
      load(script, true)
    end
  end
end
