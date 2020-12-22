require_relative 'passport_validator'

input_file = ARGV[0]
part = ARGV[1] || '1'

passports = []
passport_validator = PassportValidator.new

passport = {}
File.readlines(input_file).each do |line|
  line.chomp!
  if line.empty?
    passports << passport.dup
    passport = {}
  else
    hash_components = line.split(' ')
    hash_components.each do |component|
      hash_component = component.split(':')
      passport[hash_component[0]] = hash_component[1]
    end
  end
end

unless passport.empty?
  passports << passport
end

strict_mode = part == '2'

valid_passwords = 0
passports.each do |passport|
  valid_passwords += 1 if passport_validator.valid?(passport, strict_mode)
end

puts valid_passwords
