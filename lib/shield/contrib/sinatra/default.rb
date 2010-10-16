module Shield
  module Sinatra
    module Default
      def self.registered(m)
        m.set :shield_redirect_after_login,  "/"
        m.set :shield_redirect_after_logout, "/"
        m.set :shield_auth_failure, "Wrong Username and/or Password combination."

        m.enable :sessions

        m.helpers Shield::Helpers
        m.helpers do
          def current_user
            authenticated(User)
          end

          def is_logged_in?
            !! current_user
          end

          def ensure_authenticated(model = User)
            super
          end
        end

        m.get "/login" do
          haml :login
        end

        m.post "/login" do
          if login(User, params[:username], params[:password])
            redirect settings.shield_redirect_after_login
          else
            session[:error] = settings.shield_auth_failure
            redirect "/login"
          end
        end

        m.get "/logout" do
          logout(User)
          redirect settings.shield_redirect_after_logout
        end
      end
    end
  end
end