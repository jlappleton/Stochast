Rails.application.routes.draw do
  #get 'ticker_symbol/index'
  #get 'ticker_symbol/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ticker_symbol, only: [:index, :show]
  root 'ticker_symbol#index'
end
