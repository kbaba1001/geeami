module Web::Controllers::Session
  class Create
    include Web::Action

    params Class.new(Web::Validations::Base) {
      validations do
        configure do
          def self.messages
            super.merge(
              en: { errors: { authenticate: '不正なパスワードです' } }
            )
          end
        end

        required(:session).schema do
          required(:email).value(:filled?, :email?)
          required(:password).value(:filled?)

          # FIXME errorsの中身が {authenticate: 'xxx'} になるが、 {session: {authenticate: 'xxx'}} の方が扱いやすいので
          # そうしたいが、dry-validation にそういう機能がなさそう
          validate(authenticate: [:email, :password]) do |email, password|
            if user = UserRepository.new.find_by_email(email)
              Auth::Password.compare?(user.password_digest, password)
            else
              false
            end
          end
        end
      end
    }

    def call(params)
      if params.valid?
        user = UserRepository.new.find_by_email(params.dig(:session, :email))
        sign_in(user)

        redirect_to '/'
      else
        self.status = 422
      end
    end
  end
end
