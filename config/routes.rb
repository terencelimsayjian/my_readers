Rails.application.routes.draw do
  root 'static_pages#index'

  get 'static_pages/index'
  get 'static_pages/facilitator_home'

  namespace :admin do
    resources :facilitators, only: [:show, :index] do
      resources :projects, only: [:new, :create]
    end
    end

  namespace :facilitator do
    resources :projects, only: [:index]
  end

  devise_for :facilitators, controllers: {
    sessions: 'facilitators/sessions',
    passwords: 'facilitators/passwords',
    invitations: 'facilitators/invitations'
  }
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
end
