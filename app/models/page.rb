# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  full_text  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :slug, presence: true
end
