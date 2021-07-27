Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products do
    resources :purchase_histories, only: [:index, :create]
  end
end
