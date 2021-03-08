Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :airports,
            only: [:index] do
    collection do
      get :given_radius
      get :distance
      get :closest
      get :shortest_route
    end
  end
end
