class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer

    @address = Address.where(customer_id: current_customer)

    #カート内商品がなければnewにパス
    cart_items = current_customer.cart_items
    if cart_items.empty?
       redirect_to cart_items_path
    end
  end

  def comfirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @ship_cost = 800

    @cart_items.each do |cart_item|
      @total_price = cart_item.item.price * cart_item.amount
    end

    @total_payment = @total_price * 1.1 + @ship_cost

    @order.payment_method = params[:order][:payment_method]
    shipping = params[:order][:shipping].to_i
    case shipping
    when 1
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    when 2
      @ship = params[:order][:your_address]
      @registration_address = Address.find(@ship)
      @order.postal_code = @registration_address.postal_code
      @order.address = @registration_address.address
      @order.name = @registration_address.name

    end

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    # カート商品　保存
    current_customer.cart_items.each do |cart_item|
      order_detail = @order.order_details.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price
      order_detail.save
      cart_item.destroy
    end
      render :complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
   params.require(:order).permit(:customer_id, :payment_method, :name, :address, :postal_code, :shipping_cost, :total_payment, :status,
   order_details_attributes:[:order_id, :item_id, :amount, :price, :making_status])
  end

end
