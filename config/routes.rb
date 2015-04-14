Rails.application.routes.draw do

  root "plan#index"

  get "/", to: "plan#index"
  get "/plan/courses/:role", to: "plan#courses", as: :plan_courses

  devise_for :admins
  
  # get "/admin",
  scope :admin do
    resources :courses
  end

  get "admin", to: "admin#index", as: :admin_root
  authenticated :admin do
    scope :admin do
      resources :courses
    end
  end

end
