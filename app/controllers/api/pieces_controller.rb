class Api::PiecesController < ApplicationController
  include ContextControllable
  before_action :filter_protected_session
  include RestControllable

  def create
    self.current_instance = Piece.new(piece_params)
    self.current_instance.user = self.current_user
    if self.current_instance.save
      render json: self.current_instance, status: :created
    else
      self.render_errors
    end
  end

  def update
    if self.current_instance.update(piece_params)
      render json: self.current_instance, status: :ok
    else
      self.render_errors
    end
  end

  protected

  def model_context
    Piece.find_by_user self.current_user.id
  end

  private

  def piece_params
    params.permit(:title, :description)
  end

end
