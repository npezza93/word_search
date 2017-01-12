# frozen_string_literal: true
module WordSearch
  class Generator < SimpleDelegator
    include ActiveModel::Validations

    validate :can_words_fit?
    validate :valid_plane?
    validate :valid_word_bank?

    def initialize(file, x, y, z = nil)
      plane = Plane.make_from_coordinates(x, y, z)
      obj =
        if z.present?
          ThreeDimensional::Generator.new(plane, WordBank.new(file))
        else
          TwoDimensional::Generator.new(plane, WordBank.new(file))
        end

      super obj
    end

    def perform
      super

      if valid?
        plane.add_letters
        plane
      else
        false
      end
    end

    def object
      __getobj__
    end

    private

    def can_words_fit?
      errors.add(:base, words_too_long) if plane.max < word_bank.longest_length
    end

    def words_too_long
      "#{word_bank.longest_words.join(' and ')} "\
      "#{'is'.pluralize(word_bank.longest_words.count)} "\
      "too long for the word search"
    end

    def valid_plane?
      return if plane.valid?

      plane.errors.full_messages.each do |msg|
        errors.add(:base, msg)
      end
    end

    def valid_word_bank?
      return if word_bank.valid?

      word_bank.errors.full_messages.each do |msg|
        errors.add(:base, msg)
      end
    end
  end
end
