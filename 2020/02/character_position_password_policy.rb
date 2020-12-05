class CharacterPositionPasswordPolicy
  def valid_password?(password_entry)
    password_policy = password_entry.password_policy
    required_character = password_entry.required_character

    position_one = password_policy[0] - 1
    position_two = password_policy[1] - 1

    character_at_position_one = character_present?(position_one, password_entry)
    character_at_position_two = character_present?(position_two, password_entry)

    [character_at_position_one, character_at_position_two].count(true) == 1
  end

  private

  def character_present?(position, password_entry)
    password_entry.password[position] == password_entry.required_character
  end
end
