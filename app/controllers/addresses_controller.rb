class AddressesController < ApplicationController
  def create
    @address = current_order.build_address(params.require(:address).permit!)
    if @address.save
      redirect_to cart_path
    else
      redirect_to cart_path, :notice => "Please fill out valid address"

      #render :partial => "cart/address", :locals => {address: @address}
    end
  end
end
