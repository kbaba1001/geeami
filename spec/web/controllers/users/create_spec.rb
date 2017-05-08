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
    it '必須項目を入力しないケース' do
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
      assert { errors.dig(:user, :password).include?('must be filled') }
      assert { errors.dig(:user, :password_confirmation) == ['must be filled'] }
    end

    it 'emailのフォーマットが不正' do
      response = action.call(
        user: {
          email: 'user1example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      )

      errors = action.params.errors
      assert { errors.dig(:user, :email) == ['is in invalid format'] }
    end

    it 'emailが登録済みのケース' do
    end

    describe 'password は 8文字以上40文字以下、半角英数記号(_!$%@#) を使用可能' do
      it 'passwordが8文字以下のケース' do
        response = action.call(
          user: {
            email: 'user1@example.com',
            password: 'pass',
            password_confirmation: 'pass'
          }
        )

        errors = action.params.errors
        assert { errors.dig(:user, :password) == ['length must be within 8 - 40'] }
      end

      it 'passwordが40文字を超過するケース' do
        response = action.call(
          user: {
            email: 'user1@example.com',
            password: 'a' * 41,
            password_confirmation: 'a' * 41
          }
        )

        errors = action.params.errors
        assert { errors.dig(:user, :password) == ['length must be within 8 - 40'] }
      end

      it '_!$%@#がパスワードとして使える' do
        response = action.call(
          user: {
            email: 'user1@example.com',
            password: 'aaa_!$%@#123',
            password_confirmation: 'aaa_!$%@#123'
          }
        )

        errors = action.params.errors
        assert { errors.empty? }

        response = action.call(
          user: {
            email: 'user1@example.com',
            password: 'aaa_!$%@#123-',
            password_confirmation: 'aaa_!$%@#123-'
          }
        )

        errors = action.params.errors
        assert { errors.dig(:user, :password) == ['is in invalid format'] }
      end
    end

    it 'password_confirmation は password と同じ値ではないケース' do
      response = action.call(
        user: {
          email: 'user1@example.com',
          password: 'password',
          password_confirmation: 'invalid_password'
        }
      )

      errors = action.params.errors
      assert { errors.dig(:user, :password_confirmation) == ['must be equal to password'] }
    end
  end
end
