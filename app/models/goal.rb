class Goal < ActiveRecord::Base
  include UserScope

  belongs_to :piece

  validates :unit_value, numericality: true
  validates :time_unit, numericality: { only_integer: true }
  validates :piece, presence: true

end
