# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.roles.each do |role,role_value|
  Course.categories.each do |category,category_value|
    Course.create(
      name: "#{category}-#{role}",
      category: category,
      role: role,
      start_date: DateTime.now + 1.week,
      end_date: DateTime.now + 1.week + 2.hours
    )
  end
end
