class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order = order_detail.order
    ##order_detail.orderでネスト関係の親(order)を呼び出している
    #@order = Order.find(params[:id])と同義
    @orders = order.order_details
    making_ds = @orders.where(making_status: 'd' )
    ##orderのidで持ってきたすべてのorder_detailsのmaking_statusがdになったとき
    #注文内容の数　==　注文の制作ステータスがd になった数　＝＞order.status == "d"
    #@orders.count == order_making.count

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
