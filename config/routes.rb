Rails.application.routes.draw do

  namespace :admin do
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :customers, only: [:show, :index, :edit, :update]
    root to: 'homes#top'
    resources :items
    resources :genres, only: [:create, :index, :edit, :update]
  end


  namespace :public do
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
    resources :items, only: [:show, :index]
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'delete_confirm'
        patch 'delete'
      end
    end
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
