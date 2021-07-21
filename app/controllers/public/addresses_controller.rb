class Public::AddressesController < ApplicationController

before_action :authenticate_customer!

 def index
    @address = Address.new
    @addresses = current_customer.addresses
 end

 def create
    address = Address.new(Address_params)
    address.customer_id = current_customer.id
    address.save
    redirect_to addresses_path
    flash[:notice]='配送先情報を追加しました。'
 end

 def edit
    @address = Address.find(params[:id])
 end

 def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
    flash[:notice]='配送先情報を修正しました。'
 end

 def destroy
    @address = Address.find(params[:id])
    @address.customer = current_customer
    @address.destroy
    redirect_to addresses_path
    flash[:notice]='配送先を削除しました。'
 end

  private
  def address_params
    params.require(:address).permit(:postal_code,:address,:name)
  end
end