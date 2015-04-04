class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.integer :bitrix_id
      t.string :title
      t.string :state
      t.string :sub_id
      t.string :first_name
      t.string :last_name
      t.string :page
      t.string :source
      t.string :campaign
      t.string :medium
      t.string :term
      t.string :refid
      t.string :content

      t.timestamps null: false
    end
  end
end
