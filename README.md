# ![Word Search](https://raw.githubusercontent.com/google/material-design-icons/master/action/drawable-xxxhdpi/ic_search_black_18dp.png)Word Search Generator and Solver

[![Build Status](https://travis-ci.org/npezza93/word_search.svg?branch=master)](https://travis-ci.org/npezza93/word_search)
[![Code Climate](https://codeclimate.com/github/npezza93/word_search/badges/gpa.svg)](https://codeclimate.com/github/npezza93/word_search)
[![Test Coverage](https://codeclimate.com/github/npezza93/word_search/badges/coverage.svg)](https://codeclimate.com/github/npezza93/word_search/coverage)

## Install
Add WordSearch to your `Gemfile` and `bundle install`:

`gem "word_search"`

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

# To print to a file(without a filename defaults to "word_search")
❯ plane.print(file_name)

# When printing a 3D word search there are two spaces between z slices. The top slice is z = 0.
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
❯ generator = WordSearch::Generator.new("words.csv", 5, 5) # or add a z param to get a 3D word search
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

To solve or benchmark your solution script:
```ruby
❯ solver = WordSearch::Solver.new(
❯   "path/to/script", "path/to/word/bank", "path/to/word/search"
❯ )
❯ solver.perform
=> #<Benchmark::Tms:0x007fd722cc6b58 @cstime=0.07, @cutime=0.44, @label="", @real=0.5259899999946356, @stime=0.0, @total=0.51, @utime=0.0>
```
_NOTE_: Your script should be an executable ruby script that writes the location
of each letter to a file in the following format and returns the file path. Your
script should also accept command line arguments the first being the plane file
the second being the word list file.
```
h [4, 9]
e [5, 9]
l [6, 9]
l [7, 9]
o [8, 9]
---
b [6, 8]
y [7, 7]
e [8, 6]
```
