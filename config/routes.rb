Rails.application.routes.draw do

  # 設計通りのURLになるように修正
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 設計通りのURLになるように修正
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :users

  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'

end
