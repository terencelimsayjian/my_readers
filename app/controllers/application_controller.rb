class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  protected

  def authenticate_inviter!
    authenticate_admin!(force: true)
  end

  def authenticate_admin
    redirect_to static_pages_index_path unless admin_signed_in?
  end

  def authenticate_facilitator
    redirect_to static_pages_index_path unless facilitator_signed_in?
  end

  def authenticate_user
    redirect_to static_pages_index_path unless facilitator_signed_in? || admin_signed_in?
  end

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      admin_facilitators_path
    elsif resource.class == Facilitator
      facilitator_projects_path
    end
  end

end
