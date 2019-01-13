class Cart < ApplicationRecord
  has_many :cart_items
  before_save :subtotal, :discount
  before_save :total

  # Calculate cart subtotal
  def subtotal
    subtotal = cart_items.map { |item| item.price*item.quantity }.sum
    self[:subtotal] = subtotal.round(2)
  end

  # Calculate cart total
  def total
    self[:total] = (self[:subtotal] - self[:discount]).round(2)
  end

  # Calculate discount if cart has a discount code applied
  def discount
    self[:discount] = self[:discount_code].present? ? (self[:subtotal] * 0.1).round(2) : 0
  end

  # Return all items in the cart, excluding the created_at and updated_at
  # attributes just to make the hashes look nicer =)
  def items
    cart_items.map { |item| Item.find(item.item_id).attributes.except("created_at", "updated_at").merge({quantity: item.quantity}) }
  end

  # Make sure a cart cannot have a larger item quantity than the item has inventory
  # (this case can only happen if two people have the same item in the cart, and one of them checks out)
  # Example:
  #   cart 1 has item A with quantity: 5
  #   cart 2 has item A with quantity: 4
  #   item A has only 7 units in stock
  #   If cart 1 checks out, we want cart 2's quantity
  #   of item A to be updated such that it cannot be greater
  #   than the remaining inventory.
  def check_inventory
    cart_items.each do |cart_item|
      item = ensure_item_exists(cart_item.item_id)
      if item.inventory_count < cart_item.quantity
        cart_item.update!(quantity: item.inventory_count)
      end
    end
  end
end
