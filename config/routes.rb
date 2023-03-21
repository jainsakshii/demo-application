Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  } 
  root to: "main#index"
  get 'home/index', to: "home#index"
  resources :theatres
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
