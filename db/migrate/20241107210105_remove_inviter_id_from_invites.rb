class RemoveInviterIdFromInvites < ActiveRecord::Migration[7.2]
  def change
    safety_assured do
      remove_column :invites, :inviter_id, :bigint
    end
  end
end
