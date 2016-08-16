Rails.application.routes.draw do


  get 'registrations/after_sign_up_path_for'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'pages#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # After login re direct to / (invoices#index), with a prefix 'dashboard'
  authenticated :user do
    root to: 'invoices#index', as: :dashboard
  end

  resource :freelancer

  resources :invoices, except: :index

end
