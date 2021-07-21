class OrderDetail < ApplicationRecord

  enum making_status: { a: 0, b: 1, c: 2, d: 3 }

  belongs_to :order
  belongs_to :item

end
