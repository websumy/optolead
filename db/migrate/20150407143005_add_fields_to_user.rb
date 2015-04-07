class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :group, :string
    add_column :users, :company, :string
    add_column :users, :offline, :string
    add_column :users, :source, :string
    add_column :users, :payment, :string
    add_column :users, :comment, :text
  end
end
