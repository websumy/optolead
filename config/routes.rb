Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  devise_scope :user do
    post 'api/login', to: 'jwt_authentication/sessions#create'
  end

  root 'leads#index'

  namespace :bitrix do
    get 'callback'
    get 'ping'
  end

  resources :leads, only: [:index, :show]

  namespace :api do
    resources :leads, only: [:index, :show]
  end

  get '/:page_id', to: 'pages#show', as: :page

end
