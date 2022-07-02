Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :shifts, only: [:index, :update, :destroy] do 
        post :bulk_create, on: :collection
      end 
    end
  end
end
