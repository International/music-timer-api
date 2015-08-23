class Api::Pieces::PracticesController < ApplicationController
  include ContextControllable
  before_action :filter_protected_session
  include PieceControllable
  include RestControllable

  def create
    self.current_instance = Practice.new(practice_params)
    self.current_instance.piece = self.piece
    if self.current_instance.save
      render json: self.current_instance, status: :created
    else
      self.render_errors
    end
  end

  def update
    if self.current_instance.update(practice_params)
      render json: self.current_instance, status: :ok
    else
      self.render_errors
    end
  end

  protected

  def model_context
    Practice.find_by_piece self.piece.id
  end

  private

  def practice_params
    params.permit(:name, :seconds, :state,
      :recorded_at_value, :piece_id)
  end

end
