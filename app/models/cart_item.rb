# CartItem class
# Represent an copy of an Item that is contained in a Cart
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
