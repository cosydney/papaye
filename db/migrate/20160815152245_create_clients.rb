class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :company_number
      t.string :address

      t.timestamps null: false
    end
  end
end
