require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/create'

describe Web::Controllers::Users::Create do
  let(:action) { Web::Controllers::Users::Create.new }

  it 'is successful' do
    response = action.call(
      user: {
        email: 'user1@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    )

    assert { response[0] == 302 }
    assert { response[1]['Location'] ==  '/' }

    assert { action.user.email == 'user1@example.com' }
    assert { Auth::Password.compare?(action.user.password_digest, 'password')  }
  end

  describe 'with invalid params' do
    it 'is invalid' do
      response = action.call(
        user: {
          email: '',
          password: '',
          password_confirmation: ''
        }
      )

      assert { response[0] == 422 }

      errors = action.params.errors
      # TODO i18n
      assert { errors.dig(:user, :email) == ['must be filled'] }
      assert { errors.dig(:user, :password) == ['must be filled'] }
      assert { errors.dig(:user, :password_confirmation) == ['must be filled'] }
    end
  end
end
