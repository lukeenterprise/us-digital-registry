# == Schema Information
#
# Table name: outlet_users
#
#  id        :integer          not null, primary key
#  outlet_id :integer
#  user_id   :integer
#

class OutletUser < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :outlet
end
