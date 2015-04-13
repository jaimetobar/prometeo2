# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  country    :string(255)
#  partner    :string(255)
#  role       :integer
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  enum role: [:sales_eng,:sales,:delivery]
end
