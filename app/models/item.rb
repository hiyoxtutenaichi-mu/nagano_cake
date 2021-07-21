class Item < ApplicationRecord


#税込表示メソッド↓↓↓
  def add_tax_price
      (self.price * 1.10).round
  end

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  has_many :orders, through: :order_details
  attachment :image

end
