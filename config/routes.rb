Rails.application.routes.draw do

  get '/:locale', to: 'pages#home', locale: /#{Settings.locales.join('|')}/
  root "pages#home"

  scope "(:locale)", locale: /#{Settings.locales.join('|')}/ do

    get '/documentos', to: "pages#docs", as: :docs
    get '/presentaciones', to: "pages#presentations", as: :presentations
    get '/esenciales', to: "pages#start", as: :essentials
    get '/start' => redirect('/esenciales'), as: :start

    devise_for :admins, skip: [:registrations]
    as :admin do
      get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
      patch 'admins/:id' => 'devise/registrations#update', :as => 'admin_registration'
    end

    resource :plan, only:[:index,:create], controller: :plan, path: :entrenamiento do
      get '/', action: 'index'
      collection do
        get :step_1_roles
        get :step_2_accreditations
        get :step_3_schedule
        get :step_4_subscription
      end
    end

    resources :users, only:[] do
      collection do
        get "/notifications/:email_token", to: "users#edit_notifications", as: :notifications
        patch "/notifications/:email_token", to: "users#update_notifications"
      end
    end


    authenticate :admin do
      namespace :admin do
        get '/', to: 'admin#index'
        # Sidekiq admin console
        require 'sidekiq/web'
        mount Sidekiq::Web => '/sidekiq'

        resources :admins, only:[:index,:create,:destroy] do
          member do
            get :email_password_reset
          end
        end

        resources :courses, except: [:show]

        resources :users do
          resources 'subscriptions',only: [:index]  do
            collection do
              patch "/", to: :update_user_subscriptions
              get :print
            end
          end
        end

        resources :accreditations

      end
    end
  end

end
