class CharacterCountPasswordPolicy
  def valid_password?(password_entry)
    def valid_password?(password_entry)
      occurrences = password_entry.password.count(
        password_entry.required_character
      )

      password_policy = password_entry.password_policy
      occurrences >= password_policy[0] && occurrences <= password_policy[1]
    end
  end
end
