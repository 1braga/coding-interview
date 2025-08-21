Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies
  resources :companies, only: [] do
    resources :users, only: [:index]
  end
  resources :tweets, only: [:index]

  resources :users, param: :username, only: [:index, :show] do
    resources :tweets, only: [:index]

    collection do
      get :autocomplete
    end
  end

  get "reports/users_and_tweets", to: "reports#users_and_tweets"
  get "reports/companies_and_user_count", to: "reports#companies_and_user_count"

end
