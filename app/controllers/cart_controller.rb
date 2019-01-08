class CartController < ApplicationController
  def index
    render json: { cart_meta: active_cart, cart_items: active_cart.items }
  end

  def add_to_cart
    item_id = params[:item_id].to_i
    item = ensure_item_exists(item_id)

    if item.inventory_count == 0
      render json: { message: "item does not have sufficient inventory count" } and return
    end

    ids = active_cart.cart_items.map { |item| item.item_id }

    if ids.include?(item_id)
      existing_item = CartItem.find_by(item_id: item_id, cart_id: active_cart.id)
      quantity = existing_item.quantity
      if item.inventory_count - quantity == 0
        render json: { message: "item does not have sufficient inventory count" } and return
      end
      existing_item.update!(quantity: quantity + 1)
    else
      active_cart.cart_items << CartItem.create(item_id: item_id, cart_id: active_cart.id)
    end

    redirect_to '/cart'
  end

  def checkout
    
  end

end
