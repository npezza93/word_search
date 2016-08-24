require 'active_model'
require 'active_support'
require 'active_support/all'
require 'highline'
require 'csv'
require 'ruby-enum'

require 'word_searcher/version'
require 'word_searcher/plane'
require 'word_searcher/word_bank'
require 'word_searcher/crossword'

require 'word_searcher/plane/base'

require 'word_searcher/three_dimensional/plane'
require 'word_searcher/three_dimensional/point'
require 'word_searcher/three_dimensional/direction'

require 'word_searcher/two_dimensional/plane'
require 'word_searcher/two_dimensional/point'
require 'word_searcher/two_dimensional/direction'
require 'word_searcher/two_dimensional/generator'
require 'word_searcher/two_dimensional/position_word'

module WordSearcher
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
