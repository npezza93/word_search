require 'spec_helper'

describe WordSearch::WordBank do
  subject { WordSearch::WordBank.new('spec/support/words.csv') }

  it 'creates a word bank' do
    expect(subject).to be_a WordSearch::WordBank
  end

  it 'will have 3 words' do
    expect(subject.count).to eq(3)
  end

  it 'will have a longest count of 5' do
    expect(subject.longest_length).to eq(5)
  end

  it 'will have a longest word of hello' do
    expect(subject.longest_words).to include('hello')
  end

  it 'must not be an empty csv' do
    empty = WordSearch::WordBank.new('spec/support/empty_word_bank.csv')
    expect(empty.valid?).to be(false)

    expect(empty.errors.full_messages).to include('Word bank cannot be empty')
  end
end
