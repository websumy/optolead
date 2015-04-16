class LeadSerializer < ActiveModel::Serializer
  attributes :id, :title, :state, :sub_id, :first_name, :last_name,
             :page, :source, :campaign, :medium, :term, :refid, :content,
             :created_at, :updated_at, :offer
end
