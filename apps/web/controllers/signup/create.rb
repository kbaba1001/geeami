module Web::Controllers::Signup
  class Create
    include Web::Action

    params do
      required(:email).filled(:str?, format?: /@/).confirmation
      required(:password).filled(:str?).confirmation
    end

    def call(params)
      puts params[:email]             # => "alice@example.org"
      puts params[:password]          # => "secret"

      if params.valid?
        # ...
      else
        # ...
      end
    end
  end
end
