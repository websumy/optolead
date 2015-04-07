ActiveAdmin.register User do
  menu label: 'Партнеры'

  permit_params :email, :name, :last_name, :phone, :group, :company, :offline,
                :source, :payment, :comment, :refid, :password, :password_confirmation

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
      f.input :refid
      f.input :name, label: 'Имя'
      f.input :last_name, label: 'Фамилия'
      f.input :phone, label: 'Телефон'
      f.input :group, label: 'К кому Вы себя относите?'
      f.input :company, label: 'Вы работаете в команде или один?'
      f.input :offline, label: 'Вы планируете добывать Лиды из оффлайн не из интернета?'
      f.input :source, label: 'Откуда вы собираетесь поставлять трафик?'
      f.input :payment, label: 'Каким способом Вам удобнее получать деньги?'
      f.input :comment, label: 'Комментарии'

      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
