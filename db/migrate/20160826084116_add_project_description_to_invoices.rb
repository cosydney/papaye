class AddProjectDescriptionToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :project_description, :string
  end
end
