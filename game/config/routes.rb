Rails.application.routes.draw do
  #routes
   resources :throwings
   root "throwings#index"
end
