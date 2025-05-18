Rails.application.routes.draw do
  root "home#top"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  get "/users/auth/failure", to: "users/omniauth_callbacks#failure"

  devise_scope :user do
    delete "logout", to: "users/sessions#destroy", as: :logout
  end

  resources :categories do
    resources :ideas, shallow: true
  end
end
