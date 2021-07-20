class Public::CartItemsController < ApplicationController

before_action :authenticate_customer!, except: [:create]

  def index
    @cart_items = current_customer
  end

  def create
    if customer_signed_in?
      @cart_item = current_customer.cart_item.new(cart_item_params)
      @cart_items = current_customer.cart_items.all

      unless @cart_item.amount.present?
    		redirect_to request.referrer, alert: "個数を選択してください"
      else
        @cart_items.each do |cart_item|
    	    if cart_item_id == @cart_item.item_id
    			  sum_of_amount = cart_item.amount + @cart_item.amount
    			  cart_item.update_attribute(:amount, sum_of_amount)
    			  redirect_to public_cart_items_path, notice: "カートに商品を追加しました"
    			  @cart_item.delete
    	    end
  		  end
      end
    	if @cart_item.save
    		redirect_to public_cart_items_path, notice: "カートに商品を追加しました"
    	end
    else
  	  redirect_to new_customer_session_path
    end
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
		cart_item.update(cart_item_params)
		redirect_to public_cart_items_path, notice: "変更を保存しました"
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
		cart_item.destroy
		redirect_to public_cart_items_path
  end

  def all_destroy
    cart_items = current_customer.cart_items.all
    cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private

	def cart_item_params
	  params.require(:cart_item).permit(:item_id, :amount)
	end

end