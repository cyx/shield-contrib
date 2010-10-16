require File.expand_path("helper", File.dirname(__FILE__))

test "autoloads Ohm" do
  ex = nil
  begin
    Shield::Ohm
  rescue Exception => e
    ex = e
  end

  assert nil == e
end