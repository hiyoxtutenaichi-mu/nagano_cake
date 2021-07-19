class Item < ApplicationRecord

  attachment :image
  
#税込表示メソッド↓↓↓   
  def add_tax_price
      (self.price * 1.10).round
  end

end
