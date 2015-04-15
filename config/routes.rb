Rails.application.routes.draw do
  get "/", to: "plan#index"

  get "/plan/courses/:role", to: "plan#courses", as: :plan_courses
  post "/plan", to: "plan#create"

  devise_for :admins

  root "plan#index"

end
