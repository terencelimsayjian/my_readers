Rails.application.routes.draw do
  root 'static_pages#index'

  get 'static_pages/facilitator_home'
  get 'static_pages/index'

  namespace :admin do
    resources :projects, only: [:index, :show, :edit, :update]

    resources :facilitators, only: [:show, :index] do
      resources :projects, only: [:new, :create]
    end
  end

  namespace :facilitator do
    resources :projects, only: [:index, :show]
  end

  get 'student/:id/diagnostics/new', to: 'diagnostics#new', as: :new_student_diagnostic
  post 'student/:id/diagnostics', to: 'diagnostics#create', as: :student_diagnostic

  devise_for :facilitators, controllers: {
    sessions: 'facilitators/sessions',
    passwords: 'facilitators/passwords',
    invitations: 'facilitators/invitations'
  }
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
end
