Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :reviews, only: [ :create ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
