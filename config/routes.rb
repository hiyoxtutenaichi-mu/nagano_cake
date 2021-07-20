Rails.application.routes.draw do

      devise_for :admins

      namespace :admin do
         root 'homes#top'
         resources :customers, only: [:index, :show, :edit, :update]
         resources :genres, only: [:index, :create, :edit, :update]
         resources :items, only: [:new, :create, :index, :show, :edit, :update]
         resources :orders, only: [:show, :update]
         resources :order_details, only: [:update]
       end


      scope module: :public do
        root 'homes#top'

        get 'homes/about' => 'homes#about', as: 'about'


        resources :items, only: [:index, :show]

        get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
        patch 'customers/withdraw' => 'customers#withdraw',as: 'withdraw'
        resources :customers, only: [:show, :edit, :update]

        delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
        resources :cart_items, only: [:index, :update, :destroy, :create]

        resources :orders, only: [:new, :create, :index, :show]
        post 'orders/cofirm' => 'orders#comfirm', as: 'comfirm'
        get 'orders/complete' => 'orders#compleate', as: 'complete'

        resources :addresses, only: [:index, :edit, :destroy, :create, :update]
      end

      devise_for :customers, controllers: {
          sessions:      'public/sessions',
          passwords:     'public/passwords',
          registrations: 'public/registrations'
        }

end
