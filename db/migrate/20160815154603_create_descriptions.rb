class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.references :invoice, index: true, foreign_key: true
      t.text :description
      t.string :unit
      t.float :price
      t.float :amount
      t.float :vat_tax

      t.timestamps null: false
    end
  end
end
