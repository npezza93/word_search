# frozen_string_literal: true
module WordSearch
  class Solver
    attr_accessor :script, :word_bank, :plane, :master_positions

    def initialize(script, word_list_file, plane_file)
      @script = script
      @word_bank = WordBank.new(word_list_file)
      @plane = Plane.make_from_file(plane_file)
      @master_positions = {}
    end

    def execute
      Benchmark.measure do
        solution_file = load(script, true)
      end
    end

    def master_solutions
      @master_solutions ||=
        import_solutions(
          if File.exist?("solution_#{plane.digest}")
            File.read("solution_#{plane.digest}")
          else
            generate_master_solution
          end
        )
    end

    private

    def import_solutions(solution_array)
      solution_array.split("---").map do |positions|
        {
          positions.strip.split("\n").map(&:first).join =>
            positions.strip.split("\n").map.with_index do |letter, index|
              [index, JSON.parse(letter[2..-1])]
            end.to_h
        }
      end.reduce({}, :merge)
    end

    def generate_master_solution
      word_bank.map do |word|
        find_word(word)
      end.join("---")
    end

    def directions
      @directions ||=
        if plane.two_dimensional?
          WordSearch::TwoDimensional::Direction
        else
          WordSearch::ThreeDimensional::Direction
        end.values
    end

    def find_word(word)
      string = ""
      plane.catalog[word[0]].find do |point|
        directions.find do |direction|
          next if (spot = find_point(point, word.size - 1, direction)).blank? ||
                  not_found?(spot, word, point, direction)

          string = letter_positions(word, direction, point)
        end
      end

      string
    end

    def letter_positions(word, direction, point)
      solution = ""
      word.split("").each_with_index do |letter, index|
        solution += "#{letter} #{point.coordinate}\n"
        next if index == (word.length - 1)

        point = plane.find_next_point(point, direction)
      end

      solution
    end

    def not_found?(spot, word, point, direction)
      !(spot.letter == word[-1] && double_check(word, point, direction))
    end

    def find_point(point, move, direction)
      plane.dig(
        point.x + (move * direction[0]),
        point.y + (move * direction[1]),
      )
    end

    def double_check(word, point, direction)
      matching = true

      (word.length - 3).times do |i|
        matching &&= find_point(point, (1 + i), direction).letter == word[1 + i]
      end

      matching
    end
  end
end
