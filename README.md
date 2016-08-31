## ![Word Search](https://raw.githubusercontent.com/google/material-design-icons/master/action/drawable-xxxhdpi/ic_search_black_18dp.png)Word Search Generator and Solver
[![Build Status](https://travis-ci.org/npezza93/word_search.svg?branch=master)](https://travis-ci.org/npezza93/word_search)

Currently it can only generate a 2D or 3D word search with random letters in every spot and print it to a file or the screen.

```ruby
❯ plane = WordSearch::Plane.new(5, 5)
# To traverse the cartesian plane:
❯ plane[0][3]
=> #<WordSearch::TwoDimensional::Point:0x007facf1d8d7e0 @letter="u", @x=0, @y=3>
❯ puts plane.to_s
nvqgy
uhsit
zqloh
muudd
himyj

# To print to a file(without a filename defaults to 'crossword')
❯ plane.print(file_name)

# When printing a 3D crossword there are two spaces between z slices. The top slice is z = 0.
❯ puts WordSearch::Plane.new(3, 3, 2).to_s
bxv
lud
agp

esj
era
utg
```
