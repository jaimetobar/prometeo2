Rails.application.routes.draw do

  get 'users/index'

  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get 'users/show'

  get 'users/destroy'

  root "plan#index"

  get "/", to: "plan#index"
  get "/plan/courses/:role", to: "plan#courses", as: :plan_courses

  devise_for :admins
  
  # get "/admin",

  get "admin", to: "admin#index", as: :admin_root
  authenticated :admin do
    scope :admin do
      resources :courses
    end
    scope :admin do
      resources :users
    end

  end

end
