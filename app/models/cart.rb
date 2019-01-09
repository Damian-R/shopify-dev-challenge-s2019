class Cart < ApplicationRecord
  has_many :cart_items
  before_save :total, :discount, :subtotal, :check_inventory

  def subtotal
    subtotal = cart_items.map { |item| item.price*item.quantity }.sum
    self[:subtotal] = subtotal
  end

  def total
    self[:total] = self[:subtotal] - self[:discount]
  end

  def discount
    self[:discount] = self[:discount_code].present? ? self[:subtotal] * 0.1 : 0
  end

  # Return all items in the cart, excluding the created_at and updated_at
  # attributes just to make the hashes look nicer =)
  def items
    cart_items.map { |item| Item.find(item.item_id).attributes.except("created_at", "updated_at").merge({quantity: item.quantity}) }
  end

  # Make sure a cart cannot have a larger item quantity than the item has inventory
  # (this case can only happen if two people have the same item in the cart, and one of them checks out)
  def check_inventory
    cart_items.each do |cart_item|
      item = ensure_item_exists(cart_item.id)
      if item.inventory_count < cart_item.quantity
        cart_item.update!(quantity: item.inventory_count)
      end
    end
  end
end
