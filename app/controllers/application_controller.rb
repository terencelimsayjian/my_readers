class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_inviter!
    authenticate_admin!(:force => true)
  end

  def authenticate_admin
    redirect_to static_pages_index_path unless admin_signed_in?
  end

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      facilitators_path
    end
  end
end
