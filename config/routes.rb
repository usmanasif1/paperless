PaperLess::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root :to => "dashboard#index"
  
  resources :users do 
    collection do
      post 'change_role'
    end
  end
  resources :orders do 
  	collection do
  		post 'guest_order'
  	end
  	resources :notes
  end
  resources :notes

end