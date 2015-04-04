# == Schema Information
#
# Table name: leads
#
#  id         :integer          not null, primary key
#  bitrix_id  :integer
#  title      :string
#  state      :string
#  sub_id     :string
#  first_name :string
#  last_name  :string
#  page       :string
#  source     :string
#  campaign   :string
#  medium     :string
#  term       :string
#  refid      :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lead < ActiveRecord::Base
end
