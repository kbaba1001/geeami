module Web::Validations
  class Base < Hanami::Action::Params
    messages_path Hanami.root.join('config/locales/ja.yml')
  end
end
