# == Schema Information
#
# Table name: call_center_answers
#
#  id                   :integer          not null, primary key
#  lead_id              :integer
#  op_decline           :string
#  calc_calorie_box     :string
#  calorie_box          :string
#  deliv_address        :string
#  deliv_date           :string
#  price                :string
#  age                  :string
#  height               :string
#  current_weight       :string
#  desired_weight       :string
#  fiz_load_level       :string
#  day_eat_count        :string
#  day_nosh_count       :string
#  activity_level       :string
#  osobiy_status        :string
#  food_allergies       :string
#  disease              :string
#  vitamins_supplements :string
#  comment              :text
#

class CallCenterAnswer < ActiveRecord::Base
  belongs_to :lead
end
