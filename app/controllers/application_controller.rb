# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_request!
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def json_request?
    request.format.json?
  end
end
