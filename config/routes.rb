Rails.application.routes.draw do

  root "plan#index"

  devise_for :admins

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
      resources :courses
      resources :users do
        resources 'subscriptions',only: [:index]  do
          collection do
            patch "/", to: :update_user_subscriptions
          end
        end
      end

      resources :accreditations

    end
  end

  resource :users, only:[:create], controller: :users do
    collection do
      get :email_token
    end
  end

end
