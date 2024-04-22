Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/home', to: 'home#index'
  get '/about', to: 'home#about'
  get '/contact-us', to: 'home#contact_us'

  resources :posts do
    get :api_news, on: :collection
    resources :comments, except: :show
  end

  resources :categories, except: :show

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json }
    end
  end
end
