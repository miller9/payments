Rails.application.routes.draw do

  root 'charges#index'
  resources :charges, only: [:new, :create]

  # get 'epayco/result'
  # post 'epayco/confirmation'
  get "epayco/response", to: "epayco#result"
  post "epayco/confirmation", to: "epayco#confirmation"

end
