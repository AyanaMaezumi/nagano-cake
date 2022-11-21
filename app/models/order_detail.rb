class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order
# enum production_status: {製作不可: 0,製作待ち: 1,製作中: 2,製作完了: 3}
  enum production_status: {not_fabricable: 0,waiting_for_production: 1,in_production: 2,production_completed: 3}

  def subtotal
    (item.tax_price * quantity).floor
  end

end
