class AddStripeFields < ActiveRecord::Migration
  def change
    add_column :freelancers, :stripe_secret_key, :string
    add_column :freelancers, :stripe_publishable_key, :string
    add_column :clients, :stripe_customer_id, :string
  end
end
