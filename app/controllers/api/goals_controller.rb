class Api::GoalsController < ApplicationController
  include ContextControllable
  before_action :filter_protected_session
  include RestControllable

  def create
    self.current_instance = Goal.new(goal_params)
    self.current_instance.user = self.current_user
    if self.current_instance.save
      render json: self.current_instance, status: :created
    else
      self.render_errors
    end
  end

  def update
    if self.current_instance.update(goal_params)
      render json: self.current_instance, status: :ok
    else
      self.render_errors
    end
  end

  protected

  def model_context
    Goal.find_by_user self.current_user.id
  end

  private

  def goal_params
    params.permit(:time_unit, :unit_value, :piece_id)
  end

end
