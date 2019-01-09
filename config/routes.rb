Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cart, :only => [:index]
  resources :items

  get '/cart/add/:item_id' => 'cart#add_to_cart', :as => 'add_to_cart'
  get '/items/:id/purchase' => 'items#purchase', :as => 'purchase'
  get '/cart/checkout' => 'cart#checkout', :as => 'checkout'
end
