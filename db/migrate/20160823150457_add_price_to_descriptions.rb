class AddPriceToDescriptions < ActiveRecord::Migration
  def change
    add_monetize :descriptions, :price, currency: { present: false }
  end
end
