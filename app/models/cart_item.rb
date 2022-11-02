class CartItem < ApplicationRecord

   belongs_to :customer
   belongs_to :item


  def tax_price
    (item.price * 1.1).floor
  end

  def subtotal
    (item.tax_price * amount).floor
  end


end
