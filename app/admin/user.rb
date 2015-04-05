ActiveAdmin.register User do
  menu label: 'Партнеры'
  permit_params :email, :name, :refid, :password, :password_confirmation

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :refid
    actions
  end

  filter :email
  filter :name
  filter :refid

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :refid
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
