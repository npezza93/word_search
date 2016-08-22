## Crossword Puzzle Generator and Solver

Currently it can only generate a 2D or 3D crossword with random letters in every spot and print it to a file or the screen.

```ruby
❯ plane = CrosswordPuzzler::Plane.new(5, 5)
# To traverse the cartesian plane:
❯ plane[0][3]
=> #<CrosswordPuzzler::Plane::Point:0x007fb4d0e10028 @letter="u", @x=0, @y=3, @z=0>
❯ puts plane.to_s
nvqgy
uhsit
zqloh
muudd
himyj

# To print to a file(without a filename defaults to 'crossword')
❯ plane.print(file_name)

# When printing a 3D crossword there are two spaces between z slices. The top slice is z = 0.
❯ puts CrosswordPuzzler::Plane.new(3, 3, 2).to_s
bxv
lud
agp

esj
era
utg
```
