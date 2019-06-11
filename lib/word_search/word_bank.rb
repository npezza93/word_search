# frozen_string_literal: true

module WordSearch
  class WordBank < Array
    include ActiveModel::Validations

    validate :word_bank

    def initialize(file)
      if valid_file?(file)
        words = []

        CSV.foreach(file) do |row|
          words += valid_words_in_row(row)
        end

        super words.uniq
      else
        invalid_file
      end
    end

    def longest_length
      @longest_length ||= collect(&:length).max.to_i
    end

    def longest_words
      select do |word|
        word.length == longest_length
      end
    end

    private

    def word_bank
      errors.add(:base, "Word bank cannot be empty") if blank?
    end

    def valid_file?(file)
      File.file?(file) && File.extname(file) == ".csv"
    end

    def invalid_file
      errors.add(:file, "is invalid")
      false
    end

    def valid_words_in_row(row)
      row.map do |word|
        next if word.strip.length < 2

        word.strip.downcase
      end.compact
    end
  end
end
