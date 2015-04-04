Rails.application.routes.draw do
  devise_for :users
  root 'leads#index'

  namespace :bitrix do
    get 'callback'
    get 'ping'
  end

  resources :leads, only: [:index, :show]
end
