Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :countries, param: :name, :only => [:show]
  resources :guides
  get 'trouver-un-guide', to: 'countries#index', as: :countries
  get 'pages/a_savoir'
  get 'admin/upload-guides', to: 'guides#upload_guides', as: :upload_guides
  post 'admin/upload-guides', to: 'guides#post_upload_guides', as: :post_upload_guides
end
