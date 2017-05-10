module Web
  module Helpers
    module AuthenticateHelper
      def signed_in?
        !!current_user
      end

      def current_user
        @current_user ||= auth_manager.find_in_scope(session[auth_manager.session_key_name])
      end

      def sign_out
        session.clear
      end

      def sign_in(user)
        session[auth_manager.session_key_name] = auth_manager.serialize(user)
      end

      def authenticate_user!
        no_signin_redirect_logic.call unless signed_in?
      end

      private

      def auth_manager
        @auth_manager ||= Auth::Manager.new(auth_scope)
      end

      # TODO この辺のテンプレートメソッドパターン使っていたものをどうするか
      def auth_scope
        # raise NotImplementedError
        :user
      end

      # NOTE lambdaなどcallできるものを返してください
      def no_signin_redirect_logic
        # raise NotImplementedError
        -> { redirect_to '/' }
      end
    end
  end
end
