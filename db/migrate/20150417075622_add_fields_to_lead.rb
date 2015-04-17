class AddFieldsToLead < ActiveRecord::Migration
  def change
    add_column :leads, :geo, :string
    add_column :leads, :age, :string
    add_column :leads, :gender, :string
    add_column :leads, :placement, :string
  end
end
