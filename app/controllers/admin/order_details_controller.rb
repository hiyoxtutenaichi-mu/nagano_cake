class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order = order_detail.order
    @orders = order.order_details
    making_ds = @orders.where(making_status: 'd' )

    if order_detail.making_status == "c"
      order.status = "c"
      order.save
    elsif @orders.count == making_ds.count
      order.status = "d"
      order.save
    else
    end

    redirect_to request.referer
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
