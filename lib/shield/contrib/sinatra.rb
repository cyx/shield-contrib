require "shield"
require "sinatra/base"

module Shield
  module Sinatra
    autoload :Default, "shield/contrib/sinatra/default"
  end
end
