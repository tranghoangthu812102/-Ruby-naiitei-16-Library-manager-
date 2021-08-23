Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"

    get "/signup", to: "users#new"
    resources :users do
      member do
        resources :following, only: :index
        resources :follower, only: :index
      end
    end
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"


    get "/admin" => "admin#index"
    get "/user/categories", to: "categories#index"
    get "/user/books", to: "books#index"

    scope :admin do
      resources :books
      resources :categories
    end

    resources :categories
    resources :relationships, only: %i(create destroy)

  end
end
