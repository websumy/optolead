class AddPostBackUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :post_back_url, :string
  end
end
