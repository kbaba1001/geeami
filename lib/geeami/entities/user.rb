class User < Hanami::Entity
  EMAIL_FORMAT = /\s*([^@\\s]{1,64})@((?:[-\p{L}\d]+\.)+\p{L}{2,})\s*/i

  attributes do
    attribute :id, Types::Int
    attribute :email, Types::String.constrained(format: EMAIL_FORMAT)
    attribute :password_digest, Types::String
    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
