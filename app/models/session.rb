class Session < ActiveRecord::Base
  belongs_to :user
  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: self.token)
  end
end
