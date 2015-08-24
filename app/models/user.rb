class User < ActiveRecord::Base
  attr_accessor :password, :country, :state, :city
  before_save :encrypt_password, unless: :from_facebook?
  after_save :clear_password, unless: :from_facebook?
  after_save :update_references

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_PASSWORD_LENGTH = 6

  belongs_to :country_reference
  belongs_to :state_reference
  belongs_to :city_reference

  has_many :goals
  has_many :pieces

  validates :first_name, :last_name, presence: true, unless: :from_facebook?
  validates :email, presence: true, uniqueness: true,
    :format => EMAIL_REGEX, length: { in: 3..20 }, unless: :from_facebook?
  validates :password, confirmation: true,
    length: { in: MIN_PASSWORD_LENGTH..20, on: :create },
    unless: :from_facebook?
  validates :password_confirmation, presence: true,
    if: :should_confirm_password?
  validates :facebook_id, presence: { on: :create },
    numericality: { only_integer: true }, uniqueness: true,
    if: ->{ self.email.blank? && self.password.blank? }

  def authenticate( password_attempt )
    self.encrypted_password == BCrypt::Engine.hash_secret(password_attempt,
      self.salt)
  end

  def start_session
    Session.create( user: self )
  end

  def from_facebook?
    !self.facebook_id.blank?
  end

  protected

  def should_confirm_password?
    !self.from_facebook? && self.password.present?
  end

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
