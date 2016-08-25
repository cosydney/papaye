Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admini', as: 'rails_admin'
  get 'registrations/after_sign_up_path_for'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "registrations", invitations: "invitations" }


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

  root to: 'pages#home'

  resource :freelancer
  resource :client, only: [:show, :edit, :update, :destroy]

  namespace :client do
    resources :invoices, only: [:index, :show, :create] do
      # -------------- STRIPE ----------------
      resource :payment, only: [:create, :new]
    end
  end

  resources :invoices do
    member do
      get :edit_email
      post :send_email
    end
  end
  resources :pages



  # sidekiq so we authenticate users for them to be in the admin
  authenticate :user, lambda { |u| u.admin  } do
    mount Sidekiq::Web => '/sidekiq'
  end
end




