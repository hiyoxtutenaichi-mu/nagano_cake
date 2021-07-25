class Public::HomesController < ApplicationController

  def top
    # ↓↓↓↓↓　limitで(5件)のデータを抽出、作った日にちの降順(DESC)　→ 新着商品5件分
    @items = Item.limit(5).order(" created_at DESC ")
  end

  def about
  end

end
