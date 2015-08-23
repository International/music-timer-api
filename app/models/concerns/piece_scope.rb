module PieceScope
  extend ActiveSupport::Concern
  included do
    scope :find_by_piece, -> (piece_id) { where(piece_id: piece_id) }
    belongs_to :piece
    validates :piece, presence: true
  end
end
