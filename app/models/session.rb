class Session < ActiveRecord::Base

  module ClassMethods

    def login( options = {} )
      mode = options[:mode].blank? ?
        Options::Credentials : options[:mode].to_sym
      case mode
        when Options::Credentials
          validate_credentials options[:email], options[:password]
        when Options::Facebook
          validate_facebook options[:facebook_id]
      end
    end

    def validate_credentials(email, password)
      user = User.where(email: email).first
      unless user.blank?
        if user.authenticate(password)
          user.start_session
        else
          nil
        end
      else
        nil
      end
    end

    def validate_facebook( facebook_id )
      user = User.where(facebook_id: facebook_id).first
      unless user.blank?
        user.start_session
      else
        nil
      end
    end

  end

  module Options
    Credentials = :credentials
    Facebook = :facebook
  end

  extend ClassMethods

  include UserScope
  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: self.token)
  end
end
