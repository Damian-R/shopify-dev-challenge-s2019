class ItemsController < ApplicationController
  def index
    @items = params[:available] == 'true' ? Item.where('inventory_count > 0') : Item.all

    if params[:category]
      @items = @items.where('category = ?', params[:category])
    end

    render json: { items: @items, count: @items.count }, status: :ok
  end

  def show
    item_id = params[:id]
    @item = ensure_item_exists(item_id)
    render json: { item: @item }, status: :ok
  end
end
