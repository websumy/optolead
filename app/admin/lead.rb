ActiveAdmin.register Lead, as: 'Deal' do
  menu label: 'Лиды'

  permit_params :bitrix_id, :title, :state, :sub_id, :first_name, :last_name,
                :page, :source, :campaign, :medium, :term, :refid, :content

  index do
    selectable_column
    id_column
    column :bitrix_id
    column :title
    column :state
    column :page
    column :created_at
    actions
  end

  filter :bitrix_id
  filter :title
  filter :page
  filter :state
end
