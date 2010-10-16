$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))

puts "!! REMOVE THIS IN LINE: #{__LINE__} of #{__FILE__}"
$:.unshift("/Users/cyx/Labs/shield/lib")

require "shield/contrib"
require "spawn"
require "ohm"
require "rack/test"
require "sinatra/base"
require "haml"

prepare { Ohm.flush }

def setup(&block)
  @_setup = block if block_given?
  @_setup
end

class Cutest::Scope
  include Rack::Test::Methods

  def assert_redirected_to(path)
    assert 302  == last_response.status
    assert path == last_response.headers["Location"]
  end


  def session
    last_request.env["rack.session"]
  end
end