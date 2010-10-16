require File.expand_path("helper", File.dirname(__FILE__))

class User < Ohm::Model
  include Shield::Ohm::EmailPassword

  extend Spawn
  spawner do |u|
    u.email = "quentin@test.com"
    u.password = "password"
    u.password_confirmation = "password"
  end
end

test "adds email and password attributes and indices" do
  assert User.attributes.include?(:email)
  assert User.attributes.include?(:crypted_password)

  assert User.indices.include?(:email)
end

# email validation
scope do
  setup do
    User.new
  end

  test "assert present email" do |u|
    u.email = ""
    assert ! u.valid?
    assert u.errors.include?([:email, :not_present])
  end

  test "assert email format" do |u|
    u.email = "q"
    assert ! u.valid?
    assert u.errors.include?([:email, :not_email])
  end

  test "assert unique email" do |u|
    User.spawn(:email => "quentin@test.com")

    u.email = "quentin@test.com"
    assert ! u.valid?
    assert u.errors.include?([:email, :not_unique])
  end
end

# password validation on a new record
scope do
  setup do
    User.new
  end

  test "assert present password" do |u|
    u.password = ""
    assert ! u.valid?
    assert u.errors.include?([:password, :not_present])
  end

  test "assert confirmed password" do |u|
    u.password = "foobar"
    assert ! u.valid?
    assert u.errors.include?([:password, :not_confirmed])
  end
end

# password validation on an existing record
scope do
  setup do
    User.spawn(:email => "quentin@test.com")
  end

  test "no assert present when existing" do |u|
    u.password = ""
    u.password_confirmation = ""

    assert u.valid?
  end

  test "assert confirmed password when existing" do |u|
    u.password = "foobar"
    assert ! u.valid?
    assert u.errors.include?([:password, :not_confirmed])
  end

  test "password is not persisted when set as an empty string" do |u|
    u.password = ""
    assert u.save

    assert u == User.authenticate("quentin@test.com", "password")
  end
end

test "implements fetch" do
  quentin = User.spawn(:email => "quentin@test.com")
  assert quentin == User.authenticate("quentin@test.com", "password")
end