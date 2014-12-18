class CartController < ApplicationController

  def create
    if current_order.items.create(product_id: params[:product_id])
      redirect_to cart_path
    end
  end

  def show
    @weight = total_weight
    raise
    response = HTTParty.get("http://localhost:3000/shipments/new?shipment[city]=#{current_order.address.city}&shipment[state]=#{current_order.address.state}&shipment[postal_code]=#{current_order.address.postal_code}&shipment[weight]=#{current_order.total_weight}").parsed_response
  end
end
