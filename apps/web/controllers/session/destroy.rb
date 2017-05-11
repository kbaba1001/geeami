module Web::Controllers::Session
  class Destroy
    include Web::Action

    def call(params)
      sign_out
      redirect_to '/'
    end
  end
end
