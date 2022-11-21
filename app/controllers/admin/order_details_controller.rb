class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
     # データベースから中身を取り出すときは文字”　”。データを入れるときは、数字。
     # 製作ステータスが一つでも 製作中 → 注文ステータスを 製作中
     if order_detail.production_status == "in_production"
       order_detail.order.update(order_status: 2)
     # 製作ステータスが全て 製作完了 → 注文ステータスを 発送準備中
     # 一つのoeder_detailの親元のorderにアソシエーションで戻って、全てのorder_detailsをアソシエーションで取ってくる
     # whereメソッドは『検索をかける』findとは違って、whereは検索にひっかかった全ての情報を持ってこられる。　where（検索するカラム名: 条件）
     # countメソッドで、order_detailsの数と等しくなればという判定にしている。　==
     elsif order_detail.order.order_details.where(production_status: "production_completed").count == order_detail.order.order_details.count
       order_detail.order.update(order_status: 3)
     end
    redirect_to admin_order_path(order_detail.order.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end
