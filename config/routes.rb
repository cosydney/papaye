Rails.application.routes.draw do
  devise_for :users

  # After login re direct to / (invoices#index), with a prefix 'dashboard'
  authenticated :user do
    root to: 'invoices#index', as: :dashboard
  end

  root to: 'pages#home'

  resource :freelancer

  resources :invoices, except: :index

end
