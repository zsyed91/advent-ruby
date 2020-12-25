class BoardingPassParser
  def decode(location)
    rows = [0, 127]
    seats = [0, 7]
    location.split('').each do |code|
      if code == 'F'
        mid_point = mid_point(rows)
        rows[1] = rows[1] - mid_point
      elsif code == 'B'
        mid_point = mid_point(rows)
        rows[0] += mid_point
      elsif code == 'L'
        mid_point = mid_point(seats)
        seats[1] = seats[1] - mid_point
      elsif code == 'R'
        mid_point = mid_point(seats)
        seats[0] += mid_point
      end
    end

    rows[0] * 8 + seats[0]
  end

  private

  def mid_point(list)
    ((list[1].to_f - list[0].to_f) / 2).ceil
  end
end
