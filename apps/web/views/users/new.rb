module Web::Views::Users
  class New
    include Web::View

    def form
      form_for :user, '/users', method: :post do
        label :email
        email_field :email
        br
        label :password
        password_field :password
        br
        label :password_confirmation
        password_field :password_confirmation
        br
        submit 'Sign Up'
      end
    end
  end
end
