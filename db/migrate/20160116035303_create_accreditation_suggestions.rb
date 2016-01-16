class CreateAccreditationSuggestions < ActiveRecord::Migration
  def change
    create_table :accreditation_suggestions do |t|
      t.references :accreditation, index: true
      t.integer :suggestion_id

      t.timestamps
    end
  end
end
