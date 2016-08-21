class Point
  attr_accessor :x, :y, :z, :letter
  alias to_s letter

  def initialize(x, y, z = 0)
    @x = x
    @y = y
    @z = z
    @letter = ('a'..'z').to_a[rand(26)]
  end
end
