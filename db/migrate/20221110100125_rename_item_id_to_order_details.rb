class RenameItemIdToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_details, :items_id, :item_id
  end
end
