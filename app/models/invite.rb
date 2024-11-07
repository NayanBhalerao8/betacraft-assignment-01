# == Schema Information
#
# Table name: invites
#
#  id            :bigint           not null, primary key
#  invitee_email :string           not null
#  status        :string           default("pending")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :bigint           not null
#  user_id       :bigint
#
# Indexes
#
#  index_invites_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Invite < ApplicationRecord
  belongs_to :project
  belongs_to :inviter, class_name: 'User' # assuming inviter is the user who sent the invite
  belongs_to :invitee, class_name: 'User', optional: true # if you want to link the invitee later

  # Scope to get pending invites
  scope :pending, -> { where(status: 'pending') }

  # Method to accept the invite
  def accept
    update(status: 'accepted')
  end

  # Method to reject the invite
  def reject
    update(status: 'rejected')
  end
end
