class Public::CartItemsController < ApplicationController

before_action :authenticate_customer!, except: [:create]

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    if customer_signed_in?
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_items = current_customer.cart_items.all

      unless @cart_item.amount.present?
    		redirect_to request.referrer, alert: "個数を選択してください"
      else
        if @cart_items.exists?(item_id: @cart_item.item_id)
          @cart_items.each do |cart_item|
      	    if cart_item.item.id == @cart_item.item_id
      			  sum_of_amount = cart_item.amount + @cart_item.amount
      			  cart_item.update_attribute(:amount, sum_of_amount)
      			  @cart_item.delete
      	    end
    		  end
    		else
    		  @cart_item.save
        end
        redirect_to cart_items_path, notice: "カートに商品を追加しました"
    	end
    else
  	 redirect_to new_customer_session_path
    end
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
		cart_item.update(cart_item_params)
		redirect_to cart_items_path, notice: "変更を保存しました"
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
		cart_item.destroy
		redirect_to cart_items_path
  end

  def all_destroy
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

	def cart_item_params
	  params.require(:cart_item).permit(:item_id, :amount)
	end

end