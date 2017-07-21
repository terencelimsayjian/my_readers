class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_inviter!
    authenticate_admin!(:force => true)
  end
end
