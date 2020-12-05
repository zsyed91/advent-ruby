require_relative 'character_count_password_policy'
require_relative 'character_position_password_policy'
require_relative 'password_entry'
require_relative 'password_entry_parser'

input_file = ARGV[0]
policy_type = ARGV[1].nil? ? 1 : ARGV[1].to_i

raise 'input file required!' if input_file.nil?

valid_passwords = 0

password_policy = if policy_type == 1
                    CharacterCountPasswordPolicy.new
                  else
                    CharacterPositionPasswordPolicy.new
                  end

File.readlines(input_file).each do |line|
  password_entry = PasswordEntryParser.parse(line.chomp)
  valid_passwords += 1 if password_policy.valid_password?(password_entry)
end

puts valid_passwords
