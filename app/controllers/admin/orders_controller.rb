class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @orders = @order.order_details
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    order_details = order.order_details
    making_as = order_details.where(making_status: 'a' )

    if order.status == "b"
      making_as.each do |order_detail|
        order_detail.making_status = "b"
        order_detail.save
      end
    end

    redirect_to request.referer
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end

end
