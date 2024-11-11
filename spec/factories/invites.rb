# == Schema Information
#
# Table name: invites
#
#  id            :bigint           not null, primary key
#  invitee_email :string           not null
#  status        :string           default("pending")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  invitee_id    :bigint
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
FactoryBot.define do
  factory :invite do
    invitee_email { "test@example.com" }
    project
    inviter { create(:user) } # Assuming you have a user factory
    invitee { create(:user) }  # Optional if you're testing for an invitee
  end
end
