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
FactoryBot.define do
  factory :invite do
    project { nil }
    inviter { nil }
    invitee_email { "MyString" }
    status { "MyString" }
  end
end
