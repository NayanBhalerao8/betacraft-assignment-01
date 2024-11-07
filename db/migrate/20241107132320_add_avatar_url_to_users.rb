class AddAvatarUrlToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :full_name, :string
  end
end
