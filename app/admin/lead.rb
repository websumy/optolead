ActiveAdmin.register Lead, as: 'Deal' do
  menu label: 'Лиды'

  permit_params :bitrix_id, :title, :state, :sub_id, :first_name, :last_name,
                :page, :source, :campaign, :medium, :term, :refid, :content, :offer,
                :geo, :age, :gender, :placement

  index do
    selectable_column
    id_column
    column :bitrix_id
    column :offer
    column :refid
    column :title
    column :state do |f|
      f.state_ru
    end
    column :page
    column :created_at
    actions
  end

  filter :bitrix_id
  filter :offer
  filter :refid
  filter :title
  filter :page
  filter :state
end
