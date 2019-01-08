class Cart < ApplicationRecord
  has_many :cart_items
  before_save :subtotal

  def subtotal
    self[:subtotal] = cart_items.map { |item| item.price*item.quantity }.sum
  end


  # Return all items in the cart, excluding the created_at and updated_at
  # attributes just to make the hashes look nicer =)
  def items
    cart_items.map { |item| Item.find(item.item_id).attributes.except("created_at", "updated_at").merge({quantity: item.quantity}) }
  end
end
