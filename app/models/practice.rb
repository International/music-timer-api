class Practice < ActiveRecord::Base
  include PieceScope
  attr_accessor :recorded_at_value

  before_save :parse_time_stamps

  validates :name, :seconds, :state, presence: true
  validates :recorded_at_value, presence: { on: :create }
  validates :seconds, numericality: true
  validates :state, numericality: { only_integer: true }

  protected

  def parse_time_stamps
    unless self.recorded_at_value.blank?
      self.recorded_at = Time.at(self.recorded_at_value.to_i).to_datetime
    end
  end

end
