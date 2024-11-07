class AddOmniauthToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :google_token, :string unless column_exists?(:users, :google_token)
    add_column :users, :google_refresh_token, :string unless column_exists?(:users, :google_refresh_token)
    add_column :users, :google_expires_at, :datetime unless column_exists?(:users, :google_expires_at)
    add_column :users, :provider, :string unless column_exists?(:users, :provider)
    add_column :users, :uid, :string unless column_exists?(:users, :uid)
  end
end
