module Web::Controllers::Users
  class Create
    include Web::Action

    expose :user

    params Class.new(Web::Validations::Base) {
      params do
        required(:user).schema do
          required(:email).value(:filled?, :email?, unique_email?: UserRepository)
          required(:password).value(:filled?, size?: 8..40, format?: /\A[\w!$%@#123]+\z/).confirmation
          required(:password_confirmation).filled(:str?)
        end
      end
    }

    def call(params)
      if params.valid?
        @user = sign_up_user

        redirect_to '/'
      else
        self.status = 422
      end
    end

    def sign_up_user
      password_digest = Auth::Password.hashing(params[:user][:password])

      UserRepository.new.create(
        email: params[:user][:email],
        password_digest: password_digest
      )
    end
  end
end
