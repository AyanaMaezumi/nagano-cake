class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_details = @order.order_details
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    # データベースから中身を取り出すときは文字”　”。データを入れるときは、数字。
    # 注文ステータスが 入金確認 → 全ての製作ステータスを 製作待ち
     if order.order_status == "payment_confirmation"
       order.order_details.update(production_status: 1)
     end
    redirect_to admin_order_path(order.id)
  end


  def index
    @customer = Customer.find(params[:id])
    @orders.find_by(customer_id: @customer.id).page(params[:page]).per(10)
  end


  private
  def order_params
    params.require(:order).permit(:order_status)
  end

end

