class PasswordEntryParser
  def self.parse(password_entry)
    parts = password_entry.split(' ')
    password_range = parts[0].split('-').map(&:to_i)
    password_character = parts[1][0]
    password = parts[2]

    PasswordEntry.new(password_range, password_character, password)
  end
end
