Rails.application.routes.draw do
  namespace :meli do
    controller :auth, as: :auth, path: '/auth' do
      get :redirect
      get :callback
    end

    resource :notifications, only: :create
  end

  namespace :api do
    jsonapi_resources :products
  end
end
