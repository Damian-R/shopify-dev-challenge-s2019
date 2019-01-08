Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cart
  resources :items

  get '/addtocart/:item_id' => 'cart#add_to_cart', :as => 'add_to_cart'
end
