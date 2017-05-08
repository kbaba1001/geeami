module Web::Validations
  class Base < Hanami::Action::Params
    messages_path Hanami.root.join('config/locales/ja.yml')

    predicate(:email?) do |value|
      /\A\s*([^@\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*\z/i === value
    end

    predicate(:unique?) do |klass, value|
      # TODO SQLの発行はRepositoryに任せたほうがよい。あと exists の方が良さそう。
      !! klass.new.send(:users).send(:where, email: 'kbaba1001@example.com').first
    end
  end
end
