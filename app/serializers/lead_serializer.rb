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
#  offer      :string
#  geo        :string
#  age        :string
#  gender     :string
#  placement  :string
#

class LeadSerializer < ActiveModel::Serializer
  attributes :id, :title, :state, :sub_id, :first_name, :last_name,
             :page, :source, :campaign, :medium, :term, :refid, :content,
             :created_at, :updated_at, :offer, :geo, :age, :gender, :placement
end
