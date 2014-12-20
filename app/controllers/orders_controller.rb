class OrdersController < ApplicationController

  def show
    @order = Order.find_by(number: params[:number])
  end

  def update #this is where we have to check if there is a cc/shipping selected?/else return an error
    order_form = OrderForm.new(current_order, params[:order])
    if order_form.save
      session[:order_number] = nil
      redirect_to order_path(order_form.order.number)
    else
      redirect_to cart_path, :notice => "Please fill out a valid credit card"
    end
  end
end
