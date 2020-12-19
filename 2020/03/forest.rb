class Forest
  attr_reader :map
  def initialize
    @map = []
  end

  def build_map(level)
    @map[@map.size] = level.split('')
  end

  def print_map
    @map.each do |level|
      puts level.join('')
    end
  end

  def traverse(slope)
    slope = Slope.new(slope)
    coordinates = Coordinate.new(slope)
    tree_count = 0
    max_width = @map[0].size - 1

    loop do
      if coordinates.x + slope.x <= max_width
        coordinates.move
      else
        new_x = (coordinates.x + slope.x) % max_width - 1
        coordinates.scan(new_x)
      end

      break if out_of_forest?(coordinates)

      tree_count += 1 if tree?(coordinates)
    end

    tree_count
  end

  private

  def out_of_forest?(coordinates)
    @map[coordinates.y].nil?
  end

  def tree?(coordinate)
    @map[coordinate.y][coordinate.x] == '#'
  end
end
