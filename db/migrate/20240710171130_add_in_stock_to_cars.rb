class AddInStockToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :in_stock, :boolean
  end
end
