class AddTranslationsToAccreditations < ActiveRecord::Migration
  def up
    Accreditation.create_translation_table!(
      {name: :string, description: :text},
      {migrate_data: true}
    )
    remove_column :accreditations, :name
    remove_column :accreditations, :description
  end
  def down
    Accreditation.drop_translation_table! migrate_data: true
  end
end
