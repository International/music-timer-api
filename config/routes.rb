Rails.application.routes.draw do
  namespace :api do
    resources :users, except: [:edit, :new, :index, :destroy]
    resources :sessions, only: [:create]
    resources :pieces, except: [:edit, :new] do
      resources :practices, except: [:edit, :new],
        controller: 'pieces/practices'
    end
    resources :goals, except: [:edit, :new]
  end
end
