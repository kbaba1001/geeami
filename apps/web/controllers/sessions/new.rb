module Web::Controllers::Sessions
  class New
    include Web::Action

    expose :session

    params Class.new(Web::Validations::Base) {
      params do
        required(:session).schema do
          required(:email).value(:filled?, :email?)
          required(:password).value(:filled?)

          # TODO 認証
        end
      end
    }

    def call(params)
      if params.valid?
        # sign_in logic

        redirect_to '/'
      else
        self.status = 422
      end
    end
  end
end
