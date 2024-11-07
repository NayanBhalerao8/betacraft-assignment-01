class CreateInvites < ActiveRecord::Migration[7.2]
  def change
    create_table :invites do |t|
      t.references :project, null: false, foreign_key: true
      t.references :inviter, null: false, foreign_key: { to_table: :users }
      t.string :invitee_email, null: false
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
