Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
      resource :user, only: [:show, :update]
    
      resources :profiles, param: :username, only: [:show]
      resources :tweets, param: :slug, except: [:edit, :new]
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


