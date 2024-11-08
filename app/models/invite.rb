# == Schema Information
#
# Table name: invites
#
#  id            :bigint           not null, primary key
#  invitee_email :string           not null
#  status        :string           default("pending")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  inviter_id    :bigint
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

  def self.check_invites_for_user(user)
    invites = where(invitee_email: user.email)
    
    invites_with_project_and_user = invites.map do |invite|
      project_name = invite.project&.name
      user_email = invite.inviter&.email # Ensure the inviter's email is fetched correctly

      invite.attributes.merge(
        project_name: project_name,
        user_email: user_email
      )
    end

    invites_with_project_and_user
  end
end
