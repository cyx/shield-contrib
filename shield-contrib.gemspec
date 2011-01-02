Gem::Specification.new do |s|
  s.name = "shield-contrib"
  s.version = "0.0.3"
  s.summary = %{A collection of implementations based on the Shield protocol.}
  s.description = %Q{
    Provides various specific implementations based on the Shield protocol.
    Examples include a drop-in Sinatra Extension, an Ohm specific model,
    and a Sequel specific model.
  }
  s.authors = ["Michel Martens", "Damian Janowski", "Cyril David"]
  s.email = ["michel@soveran.com", "djanowski@dimaion.com",
             "cyx@pipetodevnull.com"]
  s.homepage = "http://github.com/cyx/shield-contrib"
  s.files = ["lib/shield/contrib/ohm/email_password.rb", "lib/shield/contrib/ohm.rb", "lib/shield/contrib/sinatra/default.rb", "lib/shield/contrib/sinatra.rb", "lib/shield/contrib.rb", "README.markdown", "LICENSE", "Rakefile", "test/helper.rb", "test/ohm_email_password_test.rb", "test/ohm_test.rb", "test/sinatra_default_test.rb"]

  s.rubyforge_project = "shield-contrib"
  s.add_dependency "shield"
  s.add_development_dependency "cutest"
  s.add_development_dependency "spawn"
  s.add_development_dependency "ohm"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "haml"
end
