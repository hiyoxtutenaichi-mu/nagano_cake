class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).reverse_order
  end

  def show
    #binding.pry
    @order = Order.find(params[:id])
    #@order_status = Order.all
  end
end
