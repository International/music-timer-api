class Practice < ActiveRecord::Base
  include PieceScope
  attr_writer :recorded_at_value

  before_save :parse_time_stamps

  validates :name, :seconds, :state, presence: true
  validates :recorded_at_value, presence: { on: :create }
  validates :seconds, numericality: true
  validates :state, numericality: { only_integer: true }

  def serializable_hash(opts = {})
    super(methods: :recorded_at_value)
  end

  def recorded_at_value
    unless self.recorded_at.blank?
      @recorded_at_value||= (self.recorded_at.to_time.to_i*1000)
    else
      @recorded_at_value
    end
  end

  protected

  def parse_time_stamps
    unless self.recorded_at_value.blank?
      self.recorded_at = Time.at(self.recorded_at_value.to_i/1000)
                          .to_datetime
    end
  end
end
