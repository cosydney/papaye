class AddProjectDescriptionToDescriptions < ActiveRecord::Migration
  def change
    add_column :descriptions, :project_description, :string
  end
end
