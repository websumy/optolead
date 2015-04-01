Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  namespace :bitrix do
    get 'index'
    get 'callback'
    get 'ping'
  end
end
