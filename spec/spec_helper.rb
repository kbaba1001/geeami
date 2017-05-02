# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require_relative '../config/environment'
require 'minitest/autorun'
require 'minitest/reporters'

class Minitest::Spec
  before do
    UserRepository.new.clear
  end
end

Minitest::Reporters.use!
Hanami.boot
