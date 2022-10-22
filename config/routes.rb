Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: "admin/sessions"
  }

  namespace :admin do

    root to:  'homes#top'
    resources :genres
    resources :items
    resources :customers
    resources :orders
  end

  scope module: :public do
    root to:  'homes#top'
    get "/about" => "homes#about", as:"about"
    # get URL => "コントローラ名#アクション名"
    resource :customers
    resources :items
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
