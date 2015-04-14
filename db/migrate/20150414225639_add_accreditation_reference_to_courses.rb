class AddAccreditationReferenceToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :accreditation, index: true
  end
end
