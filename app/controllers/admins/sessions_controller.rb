class Admins::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  layout 'no_nav_bar'

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
