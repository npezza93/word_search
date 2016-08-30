module WordSearch
  class WordBank < Array
    include ActiveModel::Validations

    validate :word_bank

    def initialize(file)
      words = []

      CSV.foreach(file) do |row|
        row.each do |word|
          words << word.strip.downcase if word.strip.length > 1
        end
      end

      super words.uniq
    end

    def longest_length
      @longest ||= collect(&:length).max
    end

    def longest_words
      select do |word|
        word.length == longest_length
      end
    end

    private

    def word_bank
      errors.add(:base, 'Word bank cannot be empty') if blank?
    end
  end
end
