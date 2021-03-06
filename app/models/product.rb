# == Schema Information
#
# Table name: products
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  category :integer
#  logo_url :string(255)
#

class Product < ActiveRecord::Base
  enum category: [
    :developer_tools, :middleware_and_application_services,
    :container_platforms, :infrastructure_software, :security_and_management
  ]

  has_many :course_products, dependent: :destroy
  has_many :courses, through: :course_products

  validates :category, presence: true
  validates :name, presence: true

  def name_with_category
    "#{category.to_s.humanize} - #{name}"
  end
end
