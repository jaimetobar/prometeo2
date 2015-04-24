class RemoveAccreditationReferenceFromCourse < ActiveRecord::Migration
  def change
    remove_reference :courses, :accreditation
  end
end
