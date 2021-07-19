class Public::CartItemsController < ApplicationController

before_action :authenticate_customer!, except: [:create]

  def index
    @cart_products = current_customer.cart_products.all
  end

  def create
    if customer_signed_in?
      @cart_product = current_customer.cart_products.new(cart_product_params)
      @cart_products = current_customer.cart_products.all

      unless @cart_product.quantity.present?
    		redirect_to request.referrer, alert: "個数を選択してください"
      else
        @cart_products.each do |cart_product|
    	    if cart_product.product_id == @cart_product.product_id
    			  sum_of_quantity = cart_product.quantity + @cart_product.quantity
    			  cart_product.update_attribute(:quantity, sum_of_quantity)
    			  redirect_to public_cart_products_path, notice: "カートに商品を追加しました"
    			  @cart_product.delete
    	    end
  		  end
      end
    	if @cart_product.save
    		redirect_to public_cart_products_path, notice: "カートに商品を追加しました"
    	end
    else
  	  redirect_to new_customer_session_path
    end
  end

  def update
    cart_product = current_customer.cart_products.find(params[:id])
		cart_product.update(cart_product_params)
		redirect_to public_cart_products_path, notice: "変更を保存しました"
  end

  def destroy
    cart_product = current_customer.cart_products.find(params[:id])
		cart_product.destroy
		redirect_to public_cart_products_path
  end

  def all_destroy
    cart_products = current_customer.cart_products.all
    cart_products.destroy_all
    redirect_to public_cart_products_path
  end

  private

	def cart_product_params
	  params.require(:cart_product).permit(:product_id, :quantity)
	end

end