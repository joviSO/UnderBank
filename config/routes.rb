Rails.application.routes.draw do
  root "accounts#index"

  resources :accounts
  devise_for :clients

  get "transaction/new_deposit", to: 'transactions#new_deposit'
  post 'transaction/create_deposit', to: 'transactions#create_deposit'
  get 'transaction/:id', to: 'transactions#show', as: :transaction

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
