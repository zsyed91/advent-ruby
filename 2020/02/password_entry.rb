class PasswordEntry
  attr_reader :password_policy, :required_character, :password

  def initialize(password_policy, required_character, password)
    @password_policy = password_policy
    @required_character = required_character
    @password = password
  end
end
