class ItemsController < ApplicationController

  # Index route to display all available items
  def index
    items = params[:available] == 'true' ? Item.where('inventory_count > 0') : Item.all

    if params[:category]
      items = items.where('category = ?', params[:category])
    end

    render json: { items: items, count: items.count }, status: :ok
  end

  # Show route to display item with specific ID
  def show
    item_id = params[:id]
    item = ensure_item_exists(item_id)
    render json: { item: item }, status: :ok
  end

  # Purchase route for purchasing individual items (independent of cart)
  def purchase
    item_id = params[:id]
    item = ensure_item_exists(item_id)
    stock = item.inventory_count
    message = "insufficient stock to purchase item id #{item_id}"
    if stock > 0
      item.update_attribute(:inventory_count, stock - 1)
      message = "successfully purchased item id #{item_id}"
    end
    render json: { message: message, item: item }
  end
end
