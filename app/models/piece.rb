class Piece < ActiveRecord::Base
  include UserScope

  validates :title, :description, presence: true

  has_many :practices

end
