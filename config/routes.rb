Rails.application.routes.draw do

  devise_for :users
  root to: "pages#index"

  resources :products do
    resources :reviews, except: [:index, :show]
  end
end
