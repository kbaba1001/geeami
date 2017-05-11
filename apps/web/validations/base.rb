module Web::Validations
  class Base < Hanami::Action::Params
    messages_path 'config/locales/ja.yml'

    # FIXME yamlからメッセージを取れないっぽい
    predicate(:email?, message: "メールアドレスのフォーマットが不正です") do |value|
      /\A\s*([^@\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*\z/i === value
    end

    predicate(:unique_email?, message: 'メールアドレスは登録済みです') do |klass, value|
      ! klass.new.find_by_email(value)
    end
  end
end
