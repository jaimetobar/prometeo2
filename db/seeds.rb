lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"

User.roles.each do |role,role_value|
  Course.categories.each do |category,category_value|
    a = Accreditation.create(
      name: "#{role.to_s.titlecase} #{category.to_s.titlecase} god"
    )
    3.times do |i|
      c = Course.create(
        name: "#{category}-#{role} level #{i}",
        accreditation: a,
        category: category,
        for_sales_engineer: role.to_s == "sales_engineer",
        for_sales: role.to_s == "sales",
        for_delivery: role.to_s == "delivery",
        session_type: [:always_available,:per_session][rand(2)],
        description: lorem_ipsum
      )
      if c.per_session?
        3.times do |j|
          CourseSession.create(
            course:c,
            start_date: DateTime.now + 2.months + j.days,
            end_date: DateTime.now + 2.months + j.days + rand(3).days + 1.hour
          )
        end
      end
    end
  end
end

Admin.create(email: "admin@admin.org", password: "12345678", password_confirmation: "12345678")
