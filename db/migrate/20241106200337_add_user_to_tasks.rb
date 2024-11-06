class AddUserToTasks < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def change
    add_reference :tasks, :user, index: { algorithm: :concurrently }
  end
end