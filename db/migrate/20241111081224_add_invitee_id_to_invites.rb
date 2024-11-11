class AddInviteeIdToInvites < ActiveRecord::Migration[7.2]
  def change
    add_column :invites, :invitee_id, :bigint
  end
end
