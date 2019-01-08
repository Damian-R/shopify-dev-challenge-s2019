module ApplicationHelper
  def active_cart
    cart = session[:cart].nil? ? Cart.create : Cart.find(session[:cart])
    session[:cart] = cart.id
    cart
  end

  # @param id [String] item id
  # This method simply tries to find an item with the given ID
  # and will cause an error and trigger ApplicationController#not_found
  # if the item does not exist
  def ensure_item_exists(id)
    Item.find(id)
  end
end
