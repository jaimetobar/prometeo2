# == Schema Information
#
# Table name: course_products
#
#  id         :integer          not null, primary key
#  product_id :integer
#  course_id  :integer
#

class CourseProduct < ActiveRecord::Base
  belongs_to :course
  belongs_to :product
end
