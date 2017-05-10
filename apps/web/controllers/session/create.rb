module Web::Controllers::Session
  class Create
    include Web::Action

    params Class.new(Web::Validations::Base) {
      params do
        required(:session).schema do
          required(:email).value(:filled?, :email?)
          required(:password).value(:filled?)

          # TODO 認証。入力されたパスワードが妥当かどうか
        end
      end
    }

    def call(params)
      if params.valid?
        # sign_in logic
        user = UserRepository.new.users.where(email: params.dig(:session, :email)).one!
        sign_in(user)

        redirect_to '/'
      else
        self.status = 422
      end
    end
  end
end
