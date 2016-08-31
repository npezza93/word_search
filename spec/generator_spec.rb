require 'spec_helper'

describe WordSearch::Generator do
  describe WordSearch::TwoDimensional::Generator do
    subject { WordSearch::Generator.new('spec/support/words.csv', 5, 5) }

    it 'makes a generator' do
      expect(subject).to be_a WordSearch::Generator
    end

    it 'generates a 2D word search' do
      expect(subject.perform)
    end
  end

  describe WordSearch::ThreeDimensional::Generator do
    subject { WordSearch::Generator.new('spec/support/words.csv', 5, 5, 5) }

    it 'generates a 3D word search' do
      expect(subject.perform)
    end
  end
end
