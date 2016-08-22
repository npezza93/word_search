module CrosswordPuzzler
  class Crossword
    include ActiveModel::Validations
    attr_accessor :plane, :word_bank

    validate :can_words_fit?
    validate :valid_plane?

    def initialize(file, x, y, z = nil)
      @plane = Plane.new(x, y, z)
      @word_bank = WordBank.new(file)
    end

    private

    def can_words_fit?
      unless [plane.x, plane.y].max > (longest = word_bank.longest)
        words = word_bank.words.select { |word| word.length == longest }
        errors.add(
          :base,
          "#{words.join(' and ')} #{'is'.pluralize(words.count)} "\
          'too long for the crossword'
        )
      end
    end

    def valid_plane?
      unless plane.valid?
        plane.errors.full_messages.each do |msg|
          errors.add(:base, msg)
        end
      end
    end
  end
end
