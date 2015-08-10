class AddTranslationsToCourse < ActiveRecord::Migration
  def up
    Course.create_translation_table!(
      {name: :string, description: :text},
      {migrate_data: true}
    )
    remove_column :courses, :name
    remove_column :courses, :description
  end
  def down
    Course.drop_translation_table! migrate_data: true
  end
end
