Superuploads::Application.routes.draw do
  get "uploads/index"

  get "uploads/new"

  get "uploads/create"

  get "uploads/show"
  
  resources :uploads, only: [:index, :new, :create, :show]
  
  root to: "uploads#index"
end
