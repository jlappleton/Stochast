Rails.application.routes.draw do
  #get 'ticker_symbol/index'
  #get 'ticker_symbol/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ticker_symbol, only: [:index, :show]
  get 'about', to: 'ticker_symbol#about'
  get 'prediction/:symbol/:task_id', to: 'prediction#show'
  root 'ticker_symbol#index'
  # oauth2 auth routes
  get 'auth/:provider/callback', to: 'admin#login'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'admin#logout'
  get 'dashboard', to: 'admin#dash'
end
