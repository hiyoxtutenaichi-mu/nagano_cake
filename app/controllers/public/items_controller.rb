class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_product = CartItem.new
  end


  private

  def item_params
    params.require(:item).permit(:name, :image_id, :introduction, :price, :is_active)
  end

end
