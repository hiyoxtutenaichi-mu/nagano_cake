Rails.application.routes.draw do

  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  root 'homes#top'
  get 'homes/about' => 'public/home#about', as: 'about'

  resources :items, only: [:index, :show]

  get 'custromers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch 'custromers/withdraw' => 'public/customers#withdraw',as: 'withdraw'
  resource :customers, only: [:show, :edit, :update]

  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all', as: 'destroy_all'
  resources :cart_items, only: [:index, :update, :destroy, :create]

  post 'orders/confirm' => 'orders#comfirm', as: 'comfirm'
  get 'orders/complete' => 'orders#compleate', as: 'complete'
  resources :orders, only: [:new, :create, :index, :show]

  resources :addresses, only: [:index, :edit, :destroy, :create, :update]

end
