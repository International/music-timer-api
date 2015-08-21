class User < ActiveRecord::Base
  attr_accessor :password, :country, :state, :city
  before_save :encrypt_password
  after_save :update_references
  after_save :clear_password

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_PASSWORD_LENGTH = 6

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
    :format => EMAIL_REGEX, length: { in: 3..20 }
  validates :password, { confirmation: true,
    length: { in: MIN_PASSWORD_LENGTH..20, :on => :create } }

  has_one :country_reference
  has_one :state_reference
  has_one :city_reference

  def authenticate( password_attempt )
    self.encrypted_password == BCrypt::Engine.hash_secret(password_attempt,
      self.salt)
  end

  protected

  def encrypt_password
    if self.password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password=
        BCrypt::Engine.hash_secret(self.password, self.salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def update_references
    Country.where(name: self.country).first_or_create
    State.where(name: self.state).first_or_create
    City.where(name: self.city).first_or_create
  end
end
