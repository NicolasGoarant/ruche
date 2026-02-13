Rails.application.routes.draw do
  devise_for :admins

  scope "(:locale)", locale: /fr|en|ar|uk|prs|es/ do
    root "pages#home"

    get "droits", to: "pages#droits"
    get "philosophie", to: "pages#philosophie"
    get "assistant-juridique", to: "legal#assistant"
    post "assistant-juridique/chat", to: "legal#chat"

    resources :contributions, path: "partages", only: [:index, :new, :create, :show] do
      collection do
        get :map_data
      end
    end

    resources :portraits, path: "trajectoires", only: [:index, :show]
  end

  namespace :admin do
    root to: "dashboard#index"
    resources :contributions do
      member do
        patch :publish
        patch :unpublish
      end
    end
    resources :portraits
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
