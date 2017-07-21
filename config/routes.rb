Rails.application.routes.draw do
  devise_for :facilitators, controllers: {
      sessions: 'facilitators/sessions',
      passwords: 'facilitators/passwords',
      invitations: 'facilitators/invitations'
  }

  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  root 'static_pages#index'
  get 'static_pages/index'
end
