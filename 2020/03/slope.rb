class Slope
  def initialize(slope)
    @slope = slope.to_r
  end

  def x
    @x ||= @slope.numerator
  end

  def y
    @y ||= @slope.denominator
  end
end
