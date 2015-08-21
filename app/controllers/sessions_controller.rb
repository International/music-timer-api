class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email])
    unless user.blank?
      if user.authenticate( params[:password] )
        session = Session.create( user: user )
        render json: session, status: 201
      else
        render nothing: true, :status: 401
      end
    else
      render nothing: true, :status: 401
    end
  end
end
