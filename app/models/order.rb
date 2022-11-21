class Order < ApplicationRecord

  has_many :order_details
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }

  # enumで管理, {0: 入金待ち, 1:入金確認, 2: 製作中, 3: 発送準備中, 4: 発送済み}
  enum order_status:{ awaiting_payment: 0,payment_confirmation: 1,in_production: 2,prepare_to_ship: 3,shipped: 4}

end
