class UsersController < ApplicationController

  include RestControllable

  def create
    self.current_instance = User.new(user_params)
    if self.current_instance.save
      render json: self.current_instance, status: :created
    else
      render json: { errors: self.current_instance.errors }
    end
  end

  def update
    if self.current_instance.update(user_params)
      render json: self.current_instance, status: :ok
    else
      render json: { errors: self.current_instance.errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password,
      :profile_image_url, :facebook_id, :country, :state, :city)
  end

end
