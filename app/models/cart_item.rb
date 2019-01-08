class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  def price
    item.price
  end

  def item
    unless @item
      @item = Item.find(item_id)
    end
    @item
  end
end
