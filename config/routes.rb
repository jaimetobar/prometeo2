Rails.application.routes.draw do

  root "plan#index"

  get "/", to: "plan#index"

  get "/plan/courses/:role", to: "plan#courses", as: :plan_courses
  post "/plan", to: "plan#create"

  devise_for :admins

  # get "/admin",

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
