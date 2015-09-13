Rails.application.routes.draw do
  
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :movies do
  	collection do
  		get 'search'
  	end
    resources :reviews, except: [:show, :index] do
    	member do
          put "like", to: "reviews#upvote"
        end
    end
  end

 root 'movies#index'
end
