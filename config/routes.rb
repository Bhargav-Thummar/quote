Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "bids#index"
  get "export_csv", to: "pages#export_csv"

  resources :bids do
    resources :line_item_dates, except: [:index, :show] do 
      resources :line_items, except: [:index, :show]
    end
  end
  resources :users, only: [:update, :show, :edit]

  resources :notifications, only: [] do
    collection do
      delete "/:notification_id", to: "notifications#destroy", as: :destroy
    end
  end
end
