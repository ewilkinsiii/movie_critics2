Rails.application.routes.draw do
  
  devise_for :users, :controllers => { registrations: "registrations"}

  resources :movies do
  	collection do
  		get 'search'
  	end

    resources :casts do
    end

    resources :trailers do
    end

    resources :reviews, except: [:show, :index] do
    	member do
          put "like", to: "reviews#upvote"
        end
    end
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]

  resources :users, only: [:index, :show]


 root 'movies#index'
end
