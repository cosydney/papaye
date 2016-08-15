class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :freelancer, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.date :invoice_date
      t.date :due_date
      t.integer :invoice_nr
      t.string :invoice_terms

      t.timestamps null: false
    end
  end
end
