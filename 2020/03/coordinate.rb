class Coordinate
  attr_reader :x, :y, :slope

  def initialize(slope, x = 0, y = 0)
    @slope = slope
    @x = x
    @y = y
  end

  def move
    @x += slope.x
    @y += slope.y
  end

  def scan(shift_x)
    @x = shift_x
    @y += slope.y
  end
end
