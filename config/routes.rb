Rails.application.routes.draw do

  namespace :admin do

    root to:  'homes#top'
    resources :genres
    resources :items
    resources :customers
    resources :orders
    patch "/order_details/:id" => "order_details#update", as:"detail_update"
  end

  scope module: :public do
    root to:  'homes#top'
    get "/about" => "homes#about", as:"about"
    # get URL => "コントローラ名#アクション名"
    resources :items
    get "/orders/complete" => "orders#complete"
    resources :orders
    post "/orders/confirm" => "orders#confirm"

    resources :addresses

    get 'customers/show'
    get 'customers/edit'
    patch 'customers/update'
    get '/customers/unsubscribe'
    patch '/customers/withdraw'

    delete '/cart_items/destroy_all' => "cart_items#destroy_all"
    resources :cart_items




    #退会確認画面
    get '/customers/unsubscribe' => 'customers#unsubscribe' , as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
  end

  devise_for :admin,skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
