class Public::OrdersController < ApplicationController

  def new
    # カートアイテムの中にログイン中のカスタマーのidが入ってたら、注文進める。入ってなかったら、商品一覧画面に戻る。
    if CartItem.exists?(customer_id: current_customer.id)
      @order = Order.new
    else
      redirect_to items_path
    end
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total_price = 0
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:address_id])
      @order.name = @address.name
      @order.postal_code = @address.postal_code
      @order.address = @address.address
    end
      @order_postage = 800
  end

  def create
    @order = Order.new(order_params)
    @order.order_status = 0
    @order.customer_id = current_customer.id
    @order.save!

    #カートの中のアイテムを注文履歴に移し替える。左:入れる箱＝右:箱に入れるデータ。
    current_customer.cart_items.each do |cart_item|
    order_detail = OrderDetail.new
    order_detail.item_id = cart_item.item_id
    order_detail.order_id = @order.id
    order_detail.unit_price = cart_item.item.price
    order_detail.quantity = cart_item.amount
    order_detail.save
    end
    redirect_to orders_complete_path
    #カートの中を空にする
    current_customer.cart_items.destroy_all
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:postage, :payment, :payment_method, :address, :name, :postal_code)
  end

end
