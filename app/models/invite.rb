# app/models/invite.rb
class Invite < ApplicationRecord
  belongs_to :project
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User', optional: true

  validates :invitee_email, presence: true

  scope :pending, -> { where(status: 'pending') }

  # Accept the invite
  def accept
    return false if status != 'pending'
    update(status: 'accepted')
  end

  # Reject the invite
  def reject
    return false if status != 'pending'
    update(status: 'rejected')
  end

  # Class method to check invites for a user
  def self.check_invites_for_user(user)
    invites = where(invitee_email: user.email)

    invites.map do |invite|
      invite.attributes.merge(
        project_name: invite.project&.name,
        user_email: invite.inviter&.email
      )
    end
  end

  # Check if the invite is pending
  def pending?
    status == 'pending'
  end
end