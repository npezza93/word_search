require 'spec_helper'

describe WordSearch::Generator do
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

    it 'prints the plane to a crossword file' do
      file = subject.plane.print
      expect(file.path).to eq('crossword')
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
  end
end
