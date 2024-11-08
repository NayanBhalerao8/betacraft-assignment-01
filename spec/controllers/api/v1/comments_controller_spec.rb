require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:task) { create(:task, project: project, user: user) }
    let(:comment) { create(:comment, task: task, user: user) }
  
    before do
      sign_in user
    end
  
    def json
        JSON.parse(response.body)
    end

    describe 'GET #index' do
      it 'returns comments for a task' do
        create(:comment, task: task, user: user)  # Ensure comment is created
        get :index, params: { project_id: project.id, task_id: task.id }
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(1) # Based on the number of comments
      end
    end
  
    describe 'POST #create' do
      it 'creates a new comment' do
        comment_params = { content: 'New Comment' }
        post :create, params: { project_id: project.id, task_id: task.id, comment: comment_params }
        expect(response).to have_http_status(:created)
        expect(Comment.count).to eq(1)
      end
  
      it 'returns errors when comment creation fails' do
        post :create, params: { project_id: project.id, task_id: task.id, comment: { content: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
end
  