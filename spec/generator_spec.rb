require 'spec_helper'

describe WordSearch::Generator do
  it 'fails validation when a word wont fit in the plane' do
    generator = WordSearch::Generator.new('spec/support/words.csv', 2, 2)
    expect(generator.perform).to eq(false)
    expect(generator.errors.full_messages.present?)
  end

  it 'fails validation when the word bank is empty' do
    file = 'spec/support/empty_word_bank.csv'
    generator = WordSearch::Generator.new(file, 2, 2)
    expect(generator.perform).to eq(false)

    errors = generator.errors.full_messages
    expect(errors.present?)
    expect(errors).to include('Word bank cannot be empty')
  end

  it 'fails validation when the plane fails validation' do
    generator = WordSearch::Generator.new('spec/support/words.csv', 1, 2)
    expect(generator.perform).to eq(false)

    errors = generator.errors.full_messages
    expect(errors.present?)
    expect(errors).to include('X must be greater than or equal to 2')
  end

  describe WordSearch::TwoDimensional::Generator do
    subject { WordSearch::Generator.new('spec/support/words.csv', 5, 5) }

    it 'makes a 2D generator' do
      expect(subject.object).to be_a WordSearch::TwoDimensional::Generator
    end

    it 'generates a 2D word search' do
      expect(subject.perform)
    end

    it 'puts the plane to the screen' do
      expect(subject.pto_s)
    end

    it 'prints the plane to a word search file' do
      output = subject.plane.print
      expect(output).to eq(4)
    end
  end

  describe WordSearch::ThreeDimensional::Generator do
    subject { WordSearch::Generator.new('spec/support/words.csv', 5, 5, 5) }

    it 'makes a 3D generator' do
      expect(subject.object).to be_a WordSearch::ThreeDimensional::Generator
    end

    it 'generates a 3D word search' do
      expect(subject.perform)
    end

    it 'puts the plane to the screen' do
      expect(subject.pto_s)
    end

    it 'prints the plane to a word search file' do
      output = subject.plane.print
      expect(output).to eq(28)
    end
  end
end
