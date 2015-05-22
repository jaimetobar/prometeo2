Rails.application.routes.draw do

  root "plan#index"

  devise_for :admins, skip: [:registrations]
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    patch 'admins/:id' => 'devise/registrations#update', :as => 'admin_registration'
  end

  resource :plan, only:[:index,:create], controller: :plan do
    collection do
      get :step_1_roles
      get :step_2_accreditations
      get :step_3_schedule
      get :step_4_subscription
    end
  end

  authenticated :admin do
    scope :admin do
      # Sidekiq admin console
      require 'sidekiq/web'
      mount Sidekiq::Web => '/sidekiq'

      resources :admins, only:[:index,:create,:destroy] do
        member do
          get :email_password_reset
        end
      end

      resources :courses
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

  resources :users, only:[] do
    collection do
      get "/notifications/:email_token", to: "users#edit_notifications", as: :notifications
      patch "/notifications/:email_token", to: "users#update_notifications"
    end
  end

end
