Trackerapp::Application.routes.draw do

  root to: "entries#index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  get "report" => "entries#index"

  resources :sessions

  resources :entries
  get 'settings', to: 'users#edit'

  resource :user do
    collection do
      patch :update_settings
      post :update_settings
      get :update_settings
      patch :update_password
      get :update_password
      post :update_password
    end
  end

  namespace :admin do
    get '/' => "admin#index"
    resources :projects
    resources :users
  end

end
