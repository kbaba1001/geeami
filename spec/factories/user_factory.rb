require Hanami.root.join('apps/web/controllers/users/create')

class UserFactory
  def create(params = {})
    Web::Controllers::Users::Create.new.call(
      {user: default_params.deep_merge!(params)}
    )
  end

  def default_params
    {
      email: 'user1@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end
end
