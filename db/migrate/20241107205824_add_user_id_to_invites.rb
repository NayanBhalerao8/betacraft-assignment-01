class AddUserIdToInvites < ActiveRecord::Migration[7.2]
  def change
    add_column :invites, :user_id, :bigint

    reversible do |dir|
      dir.up do
        Invite.update_all('user_id = inviter_id')
      end
    end
  end
end
