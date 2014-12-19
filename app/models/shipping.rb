class Shipping < ActiveRecord::Base

  def self.all_shipping_options(address, product_weight)
    response = HTTParty.get("http://localhost:3001/shipments/new?shipment[city]=#{address.city}&shipment[state]=#{address.state}&shipment[postal_code]=#{address.postal_code}&shipment[weight]=#{product_weight}").parsed_response
    response.flatten.sort_by { |k| k["total_price"] }
  end

  def self.shipping_cost(address, product_weight, shipping)
    self.all_shipping_options(address, product_weight).find {|option| option["service_name"] == shipping }["total_price"]
  end

end
