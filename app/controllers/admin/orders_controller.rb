class Admin::OrdersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end


  def index
    @customer = Customer.find(params[:id])
    @orders.find_by(customer_id: @customer.id).page(params[:page]).per(10)
  end

end

