Rails.application.routes.draw do
  devise_for :admins
  
  root "pages#home"

  get "droits", to: "pages#droits"
  get "assistant-juridique", to: "legal#assistant"
  post "assistant-juridique/chat", to: "legal#chat"

  resources :contributions, only: [:index, :new, :create, :show] do
    collection do
      get :map_data
    end
  end

  resources :portraits, only: [:index, :show]

  namespace :admin do
    root to: "dashboard#index"
    resources :contributions do
      member do
        patch :publish
        patch :unpublish
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
