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
require 'rails_helper'

RSpec.describe Invite, type: :model do
  # Validations
  it { should validate_presence_of(:invitee_email) }

  # Associations
  it { should belong_to(:inviter).class_name('User') }
  it { should belong_to(:project) }
  it { should belong_to(:invitee).class_name('User').optional }

  # Methods
  describe '#accept' do
    let(:invite) { create(:invite) }
    
    it 'updates the status to accepted' do
      invite.accept
      expect(invite.status).to eq('accepted')
    end
  end

  describe '#reject' do
    let(:invite) { create(:invite) }
    
    it 'updates the status to rejected' do
      invite.reject
      expect(invite.status).to eq('rejected')
    end
  end
end
