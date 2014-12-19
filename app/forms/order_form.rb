class OrderForm
  attr_accessor :order

  def initialize(order, params)
    @order = order

    if params[:shipping_service]
      @order.shipping_service = params[:shipping_service]
    end

    @order.build_credit_card(params.require(:credit_card).permit!)
  end

  def save
    @order.save
  end

end
