class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @orders = @order.order_details
  end

  def update
    #binding.pry
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to request.referer
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end

end
