require 'hanami/validations'

# エラーメッセージの表示がうまくできない
# Dry::Validation::MissingMessageError:         Dry::Validation::MissingMessageError: message for email? was not found
module EmailPredicates
  include Hanami::Validations::Predicates

  self.messages_path = Hanami.root.join('config/errors.yml')

  predicate(:email?) do |value|
    /\A\s*([^@\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*\z/i === value
  end
end
