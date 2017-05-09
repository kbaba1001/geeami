module Web::Validations
  class Base < Hanami::Action::Params
    messages_path 'config/locales/ja.yml'

    # FIXME yamlからメッセージを取れないっぽい
    predicate(:email?, message: "メールアドレスのフォーマットが不正です") do |value|
      /\A\s*([^@\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*\z/i === value
    end

    predicate(:unique?, message: 'メールアドレスは登録済みです') do |klass, value|
      # TODO SQLの発行はRepositoryに任せたほうがよい。あと exists の方が良さそう。
      ! klass.new.users.where(email: value).first
    end
  end
end
