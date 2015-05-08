# == Schema Information
#
# Table name: subscriptions
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  course_id        :integer
#  notifications_on :boolean
#  finished         :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  after_initialize :defaults

  def self.update_multiple(id,notifications_on_arr,finished_arr)
    i = 0
    update_subscriptions = Hash.new
    subscriptions = self.where(user_id: id).order('id asc')
    subscriptions.each do |subscription|
      update_subscriptions.merge!( subscription.id => { 'notifications_on' => notifications_on_arr[i], 'finished' => finished_arr[i] } )
      i += 1
    end
    self.update(update_subscriptions.keys, update_subscriptions.values)
  end

  protected
  def defaults
    self.finished ||= false
    self.notifications_on ||= true
  end

end
