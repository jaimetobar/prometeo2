Rails.application.routes.draw do

  root "plan#index"

  get "/", to: "plan#index"

  resource :plan, only:[], controller: :plan do
    collection do
      get :step_1_roles
      get :step_2_accreditations
      get :step_3_schedule
      get :step_4_subscription
    end
  end

  devise_for :admins

  get "admin", to: "admin#index", as: :admin_root

  authenticated :admin do
    scope :admin do
      resources :courses

      resources :users do
        resources 'subscriptions',only: [:index]  do
          collection do
            patch :multiple
          end
        end
      end

      resources :accreditations

    end
  end
end
