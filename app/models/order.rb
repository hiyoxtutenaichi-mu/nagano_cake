class Order < ApplicationRecord

  enum payment_method: { クレジットカード: 0, 銀行: 1 }
  enum status: { a: 0, b: 1, c: 2, d: 3, e: 4 }

  belongs_to :user
  has_many :order_details

end
