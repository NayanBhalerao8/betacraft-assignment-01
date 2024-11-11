require 'rails_helper'

RSpec.describe Api::V1::InvitesController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:invite) { create(:invite, project: project, inviter: user, invitee_email: user.email) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context 'when invite is valid' do
      it 'creates a new invite' do
        post :create, params: { project_id: project.id, invite: { invitee_email: 'invitee@example.com' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'when invite is invalid' do
      it 'returns errors' do
        post :create, params: { project_id: project.id, invite: { invitee_email: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #accept' do
    context 'when invite is pending' do
      it 'accepts the invite' do
        post :accept, params: { project_id: project.id, id: invite.id }
        expect(response).to have_http_status(:ok)
        expect(invite.reload.status).to eq('accepted')
      end
    end

    context 'when invite is not pending' do
      before { invite.update(status: 'accepted') }

      it 'does not accept the invite' do
        post :accept, params: { project_id: project.id, id: invite.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #reject' do
    context 'when invite is pending' do
      it 'rejects the invite' do
        post :reject, params: { project_id: project.id, id: invite.id }
        expect(response).to have_http_status(:ok)
        expect(invite.reload.status).to eq('rejected')
      end
    end

    context 'when invite is not pending' do
      before { invite.update(status: 'rejected') }

      it 'does not reject the invite' do
        post :reject, params: { project_id: project.id, id: invite.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #check_invites' do
    it 'returns invites for the current user' do
      create(:invite, invitee_email: user.email, project: project)
      get :check_invites
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
