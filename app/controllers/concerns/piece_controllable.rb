module PieceControllable
  extend ActiveSupport::Concern
  included do

    before_action :find_piece

    protected

    attr_accessor :piece

    def find_piece
      self.piece = Piece.find_by_id(params[:piece_id])
      if self.piece.blank?
        render(status: :not_found, nothing: true) and return false
      end
    end
  end
end
