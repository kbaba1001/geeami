require 'features_helper'

describe 'Visit home' do
  it 'is successful' do
    visit '/'

    assert { page.body.include?('geeami') }
  end
end
