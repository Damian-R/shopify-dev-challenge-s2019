class CartController < ApplicationController
  def index
    render json: { cart_meta: active_cart, cart_items: active_cart.items }
  end

  def add_to_cart
    active_cart.add_item(params[:item_id])
    redirect_to '/cart'
  end
end
