require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/create'

describe Web::Controllers::Users::Create do
  let(:action) { Web::Controllers::Users::Create.new }
  let(:params) {
    {
      user: {
        email: 'user1@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
  }

  it 'is successful' do
    response = action.call(params)

    assert { action.user.email == 'user1@example.com' }
    assert { Auth::Password.compare?(action.user.password_digest, 'password')  }
  end
end
