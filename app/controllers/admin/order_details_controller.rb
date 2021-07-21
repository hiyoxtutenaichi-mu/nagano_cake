class Admin::OrderDetailsController < ApplicationController
  
  def update
    order_status = Order_detail.find(params[:id])
    order_status.update(order_details_params)
    redirect_to request.referer
  end
  
  private
  def order_details_params
    params.require(order_detail).permit(:making_status)
  end
  
end
