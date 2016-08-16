Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


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

  resources :invoices, except: :index


  # OUR ROUTES
#                             Prefix Verb     URI Pattern                                  Controller#Action
#                      new_user_session GET      /users/sign_in(.:format)                     devise/sessions#new
#                          user_session POST     /users/sign_in(.:format)                     devise/sessions#create
#                  destroy_user_session DELETE   /users/sign_out(.:format)                    devise/sessions#destroy
# user_google_oauth2_omniauth_authorize GET|POST /users/auth/google_oauth2(.:format)          users/omniauth_callbacks#passthru
#  user_google_oauth2_omniauth_callback GET|POST /users/auth/google_oauth2/callback(.:format) users/omniauth_callbacks#google_oauth2
#                         user_password POST     /users/password(.:format)                    devise/passwords#create
#                     new_user_password GET      /users/password/new(.:format)                devise/passwords#new
#                    edit_user_password GET      /users/password/edit(.:format)               devise/passwords#edit
#                                       PATCH    /users/password(.:format)                    devise/passwords#update
#                                       PUT      /users/password(.:format)                    devise/passwords#update
#              cancel_user_registration GET      /users/cancel(.:format)                      devise/registrations#cancel
#                     user_registration POST     /users(.:format)                             devise/registrations#create
#                 new_user_registration GET      /users/sign_up(.:format)                     devise/registrations#new
#                edit_user_registration GET      /users/edit(.:format)                        devise/registrations#edit
#                                       PATCH    /users(.:format)                             devise/registrations#update
#                                       PUT      /users(.:format)                             devise/registrations#update
#                                       DELETE   /users(.:format)                             devise/registrations#destroy
#                             dashboard GET      /                                            invoices#index
#                                  root GET      /                                            pages#home
#                            freelancer POST     /freelancer(.:format)                        freelancers#create
#                        new_freelancer GET      /freelancer/new(.:format)                    freelancers#new
#                       edit_freelancer GET      /freelancer/edit(.:format)                   freelancers#edit
#                                       GET      /freelancer(.:format)                        freelancers#show
#                                       PATCH    /freelancer(.:format)                        freelancers#update
#                                       PUT      /freelancer(.:format)                        freelancers#update
#                                       DELETE   /freelancer(.:format)                        freelancers#destroy
#                              invoices POST     /invoices(.:format)                          invoices#create
#                           new_invoice GET      /invoices/new(.:format)                      invoices#new
#                          edit_invoice GET      /invoices/:id/edit(.:format)                 invoices#edit
#                               invoice GET      /invoices/:id(.:format)                      invoices#show
#                                       PATCH    /invoices/:id(.:format)                      invoices#update
#                                       PUT      /invoices/:id(.:format)                      invoices#update
#                                       DELETE   /invoices/:id(.:format)                      invoices#destroy
end
