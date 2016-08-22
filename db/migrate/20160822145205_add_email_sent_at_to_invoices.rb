class AddEmailSentAtToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :email_sent_at, :datetime
  end
end
