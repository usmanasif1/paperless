PaperLess::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root :to => "dashboard#index"
  
  resources :users do 
    collection do
      post 'change_role'
    end
    resources :orders
    
    resources :folders
  end

  resources :folders, :shallow => true, :except => [:new, :create] do
    collection do 
      get 'get_folders'
      get 'get_html'
      get 'get_folder_list'
      post 'move_folder'
    end
    resources :folders, :only => [:new, :create]
    resources :files, :only => [:new, :create]
    resources :zip_uploaders
  end


  
  resources :orders do 
  	collection do
  		post 'guest_order'
  	end
  	resources :notes
    resources :zip_uploaders do 
      collection do 
        get 'files'
      end
    end
  end
  resources :notes
  resources :zip_uploaders, only: [] do
    member do
      get 'download'
    end
  end

end