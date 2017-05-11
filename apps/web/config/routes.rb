# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get '/', to: ->(env) {
  if env['rack.session'][Auth::Manager.new(:user).session_key_name]
    # signed in
    Web::Controllers::Home::Index.new.call(env)
  else
    # un signed in
    Web::Controllers::Session::New.new.call(env)
  end
}

resources :users, only: %i(new create)
resource :session, only: %i(new create destroy)
