Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    resources :auth
    resources :video do
      collection do
        post 'share', to: 'video#share'
      end
    end
  end
end
