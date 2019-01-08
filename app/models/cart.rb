class Cart < ApplicationRecord
  has_many :cart_items
  before_save :subtotal

  def subtotal
    self[:subtotal] = cart_items.map { |item| item.price*item.quantity }.sum
  end

  def items
    cart_items.map { |item| Item.find(item.item_id).attributes.merge({quantity: item.quantity}) }
  end

  def add_item(id)
    ensure_item_exists(id)
    ids = cart_items.map { |item| item.item_id }

    if ids.include?(id.to_i)
      existing_item = CartItem.find_by(item_id: id, cart_id: self[:id])
      quantity = existing_item.quantity
      existing_item.update!(quantity: quantity + 1)
    else
      cart_items << CartItem.create(item_id: id, cart_id: self[:id])
    end
  end
end
