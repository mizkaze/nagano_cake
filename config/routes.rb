Rails.application.routes.draw do

  namespace :public do
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
  end
  namespace :public do
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
  end
  namespace :public do
    resources :items, only: [:show, :index]
  end
  namespace :admin do
    resources :customers, only: [:show, :index, :edit, :update]
  end
  namespace :public do
    resources :customers, only: [:show, :edit, :update, :delete_confirm, :delete]
  end
  namespace :admin do
    root to: 'homes#top'
  end
  namespace :admin do
    resources :items
  end

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update]
  end



  # 設計通りのURLになるように修正
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 設計通りのURLになるように修正
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }


  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'

end
