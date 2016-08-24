class RemovePriceFromDescriptions < ActiveRecord::Migration
  def change
    remove_column :descriptions, :price, :float
  end
end
