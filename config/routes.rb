Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  namespace :v1, defaults: { format: :json } do
    post 'login', to: 'sessions#login'
    post 'sign_up', to: 'sessions#sign_up'
  end
end
