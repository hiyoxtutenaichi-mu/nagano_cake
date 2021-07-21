class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
   
  end

  def update
    order_status = Order(params[:id])
    order_status.update(order_params)
    redirect_to request.referer
  end
  
  
  
  private
  
  def order_params
    params.require(order).permit(:status)
  end
  
end
