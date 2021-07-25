class Admin::HomesController < ApplicationController

  def top
    if  params[:customer_id].nil?
      orders = Order.all.order(created_at: :desc)
      @orders = orders.page(params[:page]).per(10)
    else
      @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
    end

  end

  private
   def customer_params
    params.require(:customer).permit(
       :email,
       :first_name,
       :last_name,
       :first_name_kana,
       :last_name_kana,
       :postal_code,
       :address,
       :telephone_number,
       :is_deleted
       )
   end
end
