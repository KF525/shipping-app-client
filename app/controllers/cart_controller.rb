class CartController < ApplicationController

  def create
    if current_order.items.create(product_id: params[:product_id])
      redirect_to cart_path
    end
  end

  def show
    product_weight = current_order.items.inject(0) { |sum, item| sum + item.product.weight }
    if current_order.address
      response = HTTParty.get("http://localhost:3001/shipments/new?shipment[city]=#{current_order.address.city}&shipment[state]=#{current_order.address.state}&shipment[postal_code]=#{current_order.address.postal_code}&shipment[weight]=#{product_weight}").parsed_response
      @shipping = response.flatten.sort_by { |k| k["total_price"] }
    end
  end
end
