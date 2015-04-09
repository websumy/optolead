class AddOfferToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :offer, :string
  end
end
