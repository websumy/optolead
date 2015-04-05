Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root 'leads#index'

  namespace :bitrix do
    get 'callback'
    get 'ping'
  end

  resources :leads, only: [:index, :show]
end
