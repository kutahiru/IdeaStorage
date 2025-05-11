Rails.application.routes.draw do
  root "home#top"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  get "/users/auth/failure", to: "users/omniauth_callbacks#failure"


  resources :categories do
    resources :ideas, shallow: true
  end
end
