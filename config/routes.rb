Car::Application.routes.draw do
  match 'login' => 'login#index', :as => :login
  match '/auth/facebook/callback' => "login#callback"
  root :to => 'map#index'
end
