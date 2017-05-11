require 'spec_helper'
require_relative '../../../../apps/web/controllers/session/create'
require Hanami.root.join('spec/factories/user_factory.rb')

describe Web::Controllers::Session::Create do
  let(:action) { Web::Controllers::Session::Create.new }

  before do
    UserFactory.new.create(
      email: 'user1@example.com',
      password: 'password'
    )
  end

  it 'is successful' do
    response = action.call(
      session: {
        email: 'user1@example.com',
        password: 'password'
      }
    )

    assert { response[0] == 302 }
    assert { action.exposures[:session][Auth::Manager.new(:user).session_key_name] }
  end

  describe 'invalid' do
    it 'パスワードが異なる場合サインインしない' do
      response = action.call(
        session: {
          email: 'user1@example.com',
          password: 'invalid_password'
        }
      )

      assert { response[0] == 422 }
      assert { action.exposures[:session][Auth::Manager.new(:user).session_key_name].nil? }

      errors = action.params.errors
      assert { errors.dig(:authenticate) == ['不正なパスワードです'] }
    end
  end
end
