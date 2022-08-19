Rails.application.routes.draw do
  
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    
    resources :customers do
      get '/my_page' => 'customers#show'
      get '/information/edit' => 'customers#edit'
      patch '/information' => 'customers#update'
      get '/unsubscribe' => 'customers#unsubscribe'
      patch '/withdraw' => 'customers#withdraw'
    end
    
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      delete 'cart_items/all_destroy' => 'cart_items#all_destroy'
    end
    
    resources :orders, only: [:new, :create, :index, :show] do
      post 'orders/confirm' => 'orders#confirm'
      get 'orders/complete' => 'orders#complete'
    end
    
    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  
  end
  
  
  namespace :admin do
    get '/' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end
end
