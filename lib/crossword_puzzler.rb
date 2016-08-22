require 'active_model'
require 'highline'
require 'csv'

require 'crossword_puzzler/version'
require 'crossword_puzzler/plane'
require 'crossword_puzzler/plane/base'
require 'crossword_puzzler/three_dimensional/point'
require 'crossword_puzzler/two_dimensional/point'
require 'crossword_puzzler/three_dimensional/plane'
require 'crossword_puzzler/two_dimensional/plane'
require 'crossword_puzzler/word_bank'
require 'crossword_puzzler/crossword'

module CrosswordPuzzler
  class << self
    def create(x, y, z = nil)
      Plane.new(x, y, z)
    end

    def start
      puts 'Welcome!'
      x = (ask 'Enter x: ', Integer)
      y = (ask 'Enter y: ', Integer)
      highline.choose do |menu|
        menu.prompt = 'Is this a 3D crossword?(Y/n):  '
        menu.choices(:Yes) { @z = ask 'Enter z: ', Integer }
        menu.choices(:No)
        menu.default = :No
      end

      puts Plane.new(x, y, @z).to_s
    end

    def ask(*query)
      highline.ask(*query)
    end

    def highline
      @highline ||= HighLine.new
    end
  end
end
