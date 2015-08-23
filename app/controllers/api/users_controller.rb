class Api::UsersController < ApplicationController
  include ContextControllable
  before_action :filter_protected_session, except: :create
  include RestControllable
  before_action :filter_instance_user, except: :create

  def create
    self.current_instance = User.new(user_params)
    if self.current_instance.save
      render json: self.current_instance, status: :created
    else
      self.render_errors
    end
  end

  def update
    if self.current_instance.update(user_params)
      render json: self.current_instance, status: :ok
    else
      self.render_errors
    end
  end

  def show
    mode = params[:mode].blank? ? :default : params[:mode].to_sym
    case mode
    when :details
      render json: self.current_instance, include: [:goals,
        pieces: { include: :practices }]
    else
      render json: self.current_instance
    end
  end

  protected

  def filter_instance_user
    if self.current_instance.id != self.current_user.id
      render(nothing: true, status: :forbidden) and return false
    end
  end

  def model_context
    User
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name, :password,
      :password_confirmation, :profile_image_url, :facebook_id, :country,
      :state, :city)
  end
end
