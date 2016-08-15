class CreateFreelancers < ActiveRecord::Migration
  def change
    create_table :freelancers do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.text :address
      t.text :company_nr
      t.integer :vat
      t.string :iban
      t.integer :bank_nr
      t.integer :branch_nr
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
