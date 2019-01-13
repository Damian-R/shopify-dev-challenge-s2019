class CartController < ApplicationController

  # Index route to display user's cart information
  def index
    active_cart.check_inventory
    render json: { cart_meta: active_cart, cart_items: active_cart.items }
  end

  # Route to add item to user's active cart
  def add_to_cart
    item_id = params[:item_id].to_i
    item = ensure_item_exists(item_id)

    if item.inventory_count == 0
      render json: { message: "item does not have sufficient inventory count" } and return
    end

    ids = active_cart.cart_items.map { |item| item.item_id }

    # check if item is already in user's cart
    # If the item is already present, increment it's quantity.
    # If not, add it to the cart.
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

  def add_discount
    if params[:code] == ENV['DISCOUNT_CODE']
      active_cart.update!(discount_code: params[:code])
    end
    redirect_to '/cart'
  end

  # Route for checking out cart items
  def checkout
    cart_items = active_cart.cart_items

    purchased_items = []

    # For each cart item, update the remaining stock after purchasing
    # and destroy the cart item
    cart_items.each do |cart_item|
      item = ensure_item_exists(cart_item.item_id)
      remaining_inventory = item.inventory_count - cart_item.quantity
      item.update!(inventory_count: remaining_inventory)
      purchased_items << { title: item.title, quantity_purchased: cart_item.quantity, remaining_inventory: remaining_inventory }
      cart_item.destroy
    end
    render json: { amount_paid: active_cart.total, purchased_items: purchased_items }, status: :ok
  end
end
