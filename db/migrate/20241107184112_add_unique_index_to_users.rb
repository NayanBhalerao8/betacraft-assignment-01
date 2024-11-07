class AddUniqueIndexToUsers < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_index :users, :google_uid, unique: true, algorithm: :concurrently
    add_index :users, [:uid, :provider], unique: true, algorithm: :concurrently
  end
end
