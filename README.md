# ![Word Search](https://raw.githubusercontent.com/google/material-design-icons/master/action/drawable-xxxhdpi/ic_search_black_18dp.png)Word Search Generator and Solver [![Build Status](https://travis-ci.org/npezza93/word_search.svg?branch=master)](https://travis-ci.org/npezza93/word_search)[![Code Climate](https://codeclimate.com/github/npezza93/word_search/badges/gpa.svg)](https://codeclimate.com/github/npezza93/word_search)[![Test Coverage](https://codeclimate.com/github/npezza93/word_search/badges/coverage.svg)](https://codeclimate.com/github/npezza93/word_search/coverage)

## Install
Add WordSearch to your `Gemfile` and `bundle install`:

`gem 'word_search'`

Alternatively, you can install the gem from [rubygems.org](https://rubygems.org/):

`gem install word_search`

## Usage

To create a plane with just random letters in each position:

```ruby
❯ plane = WordSearch::Plane.new(5, 5)
❯ plane.add_letters
# To traverse the cartesian plane:
❯ plane[0][3]
=> #<WordSearch::TwoDimensional::Point:0x007facf1d8d7e0 @letter="u", @x=0, @y=3>
❯ plane.pto_s
nvqgy
uhsit
zqloh
muudd
himyj

# To print to a file(without a filename defaults to 'crossword')
❯ plane.print(file_name)

# When printing a 3D crossword there are two spaces between z slices. The top slice is z = 0.
❯ plane = WordSearch::Plane.new(3, 3, 2)
❯ plane.add_letters
❯ plane.pto_s
bxv
lud
agp

esj
era
utg
```

To create plane filled with words supplied by a word bank:
```ruby
❯ generator = WordSearch::Generator.new('words.csv', 5, 5) # or add a z param to get a 3D word search
❯ generator.perform
❯ generator.word_bank
=> ["word", "hello", "bye"]
❯ generator.pto_s
ghsii
eelwt
ylcon
blarz
yoydt
```
