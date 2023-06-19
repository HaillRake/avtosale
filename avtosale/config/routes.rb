# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user_searches#home', as: 'home'
  get 'help', to: 'user_searches#help'
  get 'my_searches', to: 'user_searches#my_searches'
  get 'search', to: 'cars#search'
  get '/auto', to: 'auto#index'
  get '/home', to: 'home#index'
  get '/about-us', to: 'about_us#index'
  devise_for :users
  resources :cars
end
