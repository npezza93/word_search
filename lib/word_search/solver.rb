# frozen_string_literal: true

module WordSearch
  class Solver
    attr_accessor :script, :word_bank, :plane, :failed, :benchmark,
                  :word_list_file, :plane_file

    def initialize(script, word_list_file, plane_file)
      @script         = script
      @word_list_file = word_list_file
      @word_bank      = WordBank.new(word_list_file)
      @plane_file     = plane_file
      @plane          = Plane.make_from_file(plane_file, should_catalog: false)
      @failed         = false
    end

    def perform
      return if script.blank?
      bm = benchmark_solution

      return(@benchmark = bm) if !failed && solved?

      "Word Search incorrectly solved"
    end

    def solved?
      @word_bank.all? do |word|
        correctly_found?(word, users_solution[word])
      end && proper_direction?
    end

    private

    def benchmark_solution
      Benchmark.measure do
        begin
          users_solution
        rescue
          self.failed = true
        end
      end
    end

    def users_solution
      @users_solution ||= import_solutions(File.read(JSON.parse(
        `ruby #{script} #{plane_file} #{word_list_file}`
      )))
    end

    def correctly_found?(word, positions)
      word.split("").map.with_index do |letter, index|
        plane.letter_at(*positions[index]).letter == letter
      end.inject(:&)
    end

    def proper_direction?
      users_solution.all? do |word, positions|
        values = positions.values
        direction = reduce_direction(values.pop.zip(*values), word)
        plane.directions.values.include?(direction)
      end
    end

    def reduce_direction(values, word)
      values.map do |direction|
        gcd = direction.reduce(:gcd)
        direction.map { |coord| coord / gcd }.uniq
      end.map do |direction|
        if (direction = direction.inject(:-)).gcd(word.length) == word.length
          direction / word.length
        else
          direction
        end
      end
    end

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
  end
end
