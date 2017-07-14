Rails.application.routes.draw do
  devise_for :admins
  root 'static_pages#index'
  get 'static_pages/index'
end
