class ChangeCourseDurationToDecimal < ActiveRecord::Migration
  def up
    Course.all.each { |c| c.duration = c.duration.split(" ")[0] ; c.save! }
    change_column :courses, :duration, 'decimal USING CAST(duration AS decimal)'
  end
  def down
    change_column :courses, :duration, :string
  end
end
