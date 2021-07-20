class Public::AddressController < ApplicationController

  def create
    @address = Address.new(send_address_params)
    @address.customer_id = current_customer.id
    if @address.save
    redirect_to addresses_path, success: "作成しました"
    else 
     redirect_to addresses_path,danger:  '作成に失敗しました。'
    end
  end
  
  def index
    @customer = current_customer
    @addresses = @customer.addresses
    @address = Address.new
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path,notice: "You have updated address successfully."
    else
      render "edit"
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end