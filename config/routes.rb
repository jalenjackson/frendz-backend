Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  namespace :v1, defaults: { format: :json } do
    post 'login', to: 'sessions#login'
    post 'sign_up', to: 'sessions#sign_up'
    post 'matches', to: 'sessions#fetch_matches'
    post 'update_user', to: 'sessions#update_user'
    post 'uploads', to: 'sessions#uploads'
    post 'images', to: 'sessions#return_images'
  end
end
