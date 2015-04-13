# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  role       :integer
#  category   :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Course < ActiveRecord::Base
  enum role: [:sales_eng,:sales,:delivery]
  enum category: [:platform,:middleware,:cloud]
end
