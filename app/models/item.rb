# Class Item
# An item that is for sale
class Item < ApplicationRecord
  has_many :cart_items
end
