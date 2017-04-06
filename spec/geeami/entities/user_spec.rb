require 'spec_helper'

describe User do
  it '妥当なデータを入れるケース' do
    user = User.new(email: 'user1@example.com', password_digest: 'xxxxxxxxxx')

    assert { user.email == 'user1@example.com' }
    assert { user.password_digest == 'xxxxxxxxxx' }
  end

  describe 'invalid' do
    it 'emailのフォーマットが不正であるケース' do
      proc {
        User.new(email: 'user1example.com')
      }.must_raise TypeError
    end
  end
end
