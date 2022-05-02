Rails.application.routes.draw do

  namespace :public do
    get 'items/index'
    get 'items/show'
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
