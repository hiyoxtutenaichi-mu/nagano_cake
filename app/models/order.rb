class Order < ApplicationRecord

  enum payment_method: { クレジットカード: 0, 銀行振り込み: 1 }

  belongs_to :customer
  has_many :order_detail
  has_many :items, through: :order_details
  
  def total_price
    array = []
    self.order_details.each do |order_detail|
       array << order_detail.price * order_detail.quantity
   end
    array.sum
  end

end
