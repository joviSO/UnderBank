Rails.application.routes.draw do
  devise_for :accounts
  resources :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
