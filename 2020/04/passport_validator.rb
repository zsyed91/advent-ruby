class PassportValidator
  REQUIRED_KEYS = %w[byr iyr eyr hgt hcl ecl pid]
  VALID_EYE_COLORS = %w[amb blu brn gry grn hzl oth]

  def valid?(passport, strict_mode = false)
    REQUIRED_KEYS.each do |key|
      return false unless passport.key?(key)

      return false if strict_mode && !strictly_valid?(passport, key)
    end

    true
  end

  private

  def strictly_valid?(passport, key)
    validation_method = "valid_#{key}?"

    send(validation_method, passport[key])
  end

  def valid_byr?(value)
    return false if value.match(/^[0-9]{4}$/).nil?

    value = value.to_i
    value >= 1920 && value <= 2002
  end

  def valid_iyr?(value)
    return false if value.match(/^[0-9]{4}$/).nil?

    value = value.to_i
    value >= 2010 && value <= 2020
  end

  def valid_eyr?(value)
    return false if value.match(/^[0-9]{4}$/).nil?

    value = value.to_i
    value >= 2020 && value <= 2030
  end

  def valid_hgt?(value)
    if value.end_with?('cm')
      value = value.to_i
      value >= 150 && value <= 193
    elsif value.end_with?('in')
      value = value.to_i
      value >= 59 && value <= 76
    else
      false
    end
  end

  def valid_cid?(value)
    true
  end

  def valid_hcl?(value)
    !value.match(/^#[0-9a-z]{6}$/).nil?
  end

  def valid_ecl?(value)
    VALID_EYE_COLORS.include?(value)
  end

  def valid_pid?(value)
    !value.match(/^[0-9]{9}$/).nil?
  end
end
