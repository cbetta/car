Car::Application.routes.draw do
  match 'login' => 'login#index', as: :login
  match 'denied' => 'login#no_access', as: :no_access
  match '/auth/facebook/callback' => "login#callback"
  match "logout" => 'login#destroy', as: :logout
  root :to => 'map#index'
end
