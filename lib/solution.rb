require 'word_search'

class Solution
  attr_accessor :solved

  def initialize
    @solved = {}
  end

  def perform
    word_bank.each do |word|
      find_word(word)
    end
  end

  def plane
    @plane ||= WordSearch::Plane.make_from_file('crossword')
  end

  def word_bank
    @word_bank ||= WordSearch::WordBank.new('words.csv')
  end

  def directions
    @directions ||=
      if plane.two_dimensional?
        WordSearch::TwoDimensional::Direction
      else
        WordSearch::ThreeDimensional::Direction
      end.values
  end

  # 100 Benches - avg. 1.8195600882917642 sec
  # 100 Benches - avg. 3.1153619168809383 sec - brute force
  def find_word(word)
    plane.catalog[word[0]].find do |point|
      directions.find do |direction|
        next if (spot = find_point(point, word.size - 1, direction)).blank? &&
                check_direction(spot, word, point, direction)

        @solved[word] = { first: point, last: spot}
        spot
      end
    end
  end

  def check_direction(spot, word, point, direction)
    spot.letter != word[-1] && double_check(word, point, direction)
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
