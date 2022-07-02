class ApplicationController < ActionController::API

  protected

  def current_user
    @current_user ||= User.find_by(token: request_token) if request_token
  end

  def request_token
    request.headers['Authorization'].split.last
  end
end
