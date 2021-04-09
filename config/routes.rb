Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :topics, only: :index
    end
  end
end
