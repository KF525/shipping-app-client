class CartController < ApplicationController

  def create
    if current_order.items.create(product_id: params[:product_id])
      redirect_to cart_path
    end
  end

  def show
    if current_order.address
      @shipping = Shipping.all_shipping_options(current_order.address, current_order.product_weight)
    end
  end
end
