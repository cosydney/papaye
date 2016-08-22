class AddEmailTextToFreelancers < ActiveRecord::Migration
  def change
    add_column :freelancers, :email_text, :text
  end
end
