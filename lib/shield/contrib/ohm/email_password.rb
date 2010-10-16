module Shield
  module Ohm
    module EmailPassword
      def self.included(model)
        model.extend Shield::Model
        model.extend Fetch
        model.attribute :email
        model.index :email

        model.attribute :crypted_password
      end

      EMAIL_REGEX = /^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i

      module Fetch
        def fetch(email)
          find(:email => email).first
        end
      end

      attr_reader   :password
      attr_accessor :password_confirmation

      def validate
        super

        assert_present(:email) && assert_email(:email) && assert_unique(:email)

        assert_present(:password) if new?

        unless password.to_s.empty?
          assert password == password_confirmation, [:password, :not_confirmed]
        end
      end

      def password=(password)
        unless password.to_s.empty?
          self.crypted_password = Shield::Password.encrypt(password)
        end

        @password = password
      end

    private
      def assert_email(att, error = [att, :not_email])
        assert_format(att, EMAIL_REGEX, error)
      end
    end
  end
end