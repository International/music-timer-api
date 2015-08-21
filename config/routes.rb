Rails.application.routes.draw do
  resources :users, except: [:edit, :new]
end
