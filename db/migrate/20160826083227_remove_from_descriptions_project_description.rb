class RemoveFromDescriptionsProjectDescription < ActiveRecord::Migration
  def change
    remove_column :descriptions, :project_description
  end
end
