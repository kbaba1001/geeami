module Auth
  class Manager
    attr_reader :scope

    def initialize(scope)
      @scope = scope.to_s
    end

    def session_key_name
      "auth.id.#{scope}"
    end

    def find_in_scope(id)
      return unless id

      # TODO 抽象化したい
      UserRepository.new.users.where(id: id).one
    end

    def serialize(user)
      user.id
    end
  end
end
