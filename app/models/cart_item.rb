class CartItem < ApplicationRecord

  belongs_to :customer

  belongs_to :item

  def in_tax_price
    self.item.price * 1.10
  end

  def sub_total
    (self.in_tax_price * self.amount).round
  end

end
