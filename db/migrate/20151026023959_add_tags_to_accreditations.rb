class AddTagsToAccreditations < ActiveRecord::Migration
  def change
    add_column :accreditations, :tags, :string
  end
end
