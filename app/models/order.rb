class Order < ApplicationRecord

  enum payment_method: { クレジットカード: 0, 銀行振り込み: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 制作中: 2, 発送準備中: 3, 発送済み: 4 }

  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  def total_price
    array = []
    self.order_details.each do |order_detail|
       array << order_detail.price * order_detail.quantity
   end
    array.sum
  end

end
