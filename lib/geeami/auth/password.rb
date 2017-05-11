module Auth
  class Password
    class << self
      def hashing(password)
        BCrypt::Password.create(password)
      end

      def compare?(hashed_password, unhashed_password)
        return unless hashed_password

        BCrypt::Password.new(hashed_password) == unhashed_password
      end
    end
  end
end
