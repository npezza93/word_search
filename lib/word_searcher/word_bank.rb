module WordSearcher
  class WordBank
    attr_accessor :words

    def initialize(file)
      @words = []

      CSV.foreach(file) do |row|
        row.each do |word|
          @words << word
        end
      end
    end

    def longest
      words.map(&:length).max
    end
  end
end
