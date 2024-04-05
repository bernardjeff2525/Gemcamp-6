Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/home', to: 'home#index'
  get '/about', to: 'home#about'
  get '/contact-us', to: 'home#contact_us'

  resources :posts do
    resources :comments, except: :show
  end
end
