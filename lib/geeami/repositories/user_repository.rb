class UserRepository < Hanami::Repository
  def find_by_email(email)
    # TODO EXIST句にしたいけどやり方がよくわからない
    users.where(email: email).first
  end
end
