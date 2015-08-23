class Api::SessionsController < ApplicationController
  def create
    session = Session.login params
    unless session.blank?
      render json: session, status: :created
    else
      render nothing: true, status: :unauthorized
    end
  end

end
