require File.expand_path("helper", File.dirname(__FILE__))

class App < Sinatra::Base
  register Shield::Sinatra::Default

  set :shield_redirect_after_login, "/dashboard"
  set :shield_redirect_after_logout, "/thank-you"

  set :views, File.join(File.dirname(__FILE__), "fixtures", "views")

  get "/dashboard" do
    ensure_authenticated

    "Dashboard"
  end

  get "/thank-you" do
    "Thank you."
  end
end

class User < Struct.new(:id)
  def self.authenticate(username, password)
    new(1001) if ["quentin", "password"] == [username, password]
  end
end
scope do
  def app
    App.new
  end

  test "GET /login" do
    get "/login"
    assert "<h1>Login</h1>\n" == last_response.body
  end

  test "POST /login" do
    post "/login", :username => "quentin", :password => "password"
    assert 1001 == session["User"]

    assert_redirected_to "/dashboard"
    follow_redirect!

    assert "Dashboard" == last_response.body
  end

  test "GET /logout" do
    post "/login", :username => "quentin", :password => "password"
    get "/logout"

    assert_redirected_to "/thank-you"
  end
end