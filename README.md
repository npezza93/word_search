```ruby
# frozen_string_literal: true
require "word_search"

class Solution
  attr_accessor :plane_file, :word_bank, :output
  delegate :directions, to: :plane

  def initialize(plane_file, word_bank_file, output)
    @plane_file = plane_file || "word_search"
    @word_bank  = WordSearch::WordBank.new(word_bank_file || "words.csv")
    @output     = output || "solution"
  end

  def perform
    File.open(output, "w") { |f| f.write(positions) }

    output
  end

  def plane
    @plane ||= WordSearch::Plane.make_from_file(plane_file)
  end

  def positions
    @positions ||=
      word_bank.map do |word|
        find_word(word)
      end.join("---\n")
  end

  def find_word(word)
    string = ""

    plane.catalog[word[0]].find do |point|
      directions.values.find do |direction|
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

    (word.length - 2).times do |i|
      matching &&= find_point(point, (1 + i), direction).letter == word[1 + i]
    end

    matching
  end
end

s = Solution.new(ARGV[0], ARGV[1], ARGV[2])
puts s.perform
```
