ActiveAdmin.register Page do
  menu label: 'Страницы'
  controller { defaults finder: :find_by_slug }
  permit_params :name, :slug, :full_text

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :full_text, input_html: {:class => 'editor'}
    end
    f.actions
  end

end
