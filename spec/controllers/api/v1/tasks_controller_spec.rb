require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project, user: user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a new task' do
      task_params = { title: 'New Task', description: 'Test task' }
      post :create, params: { project_id: project.id, task: task_params }
      expect(response).to have_http_status(:created)
      expect(Task.count).to eq(1) # Expect a task to be created
    end

    it 'returns errors when task creation fails' do
      post :create, params: { project_id: project.id, task: { title: '', description: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT #update' do
    it 'updates an existing task' do
      put :update, params: { project_id: project.id, id: task.id, task: { title: 'Updated Task' } }
      expect(response).to have_http_status(:ok)
      expect(task.reload.title).to eq('Updated Task')
    end

    it 'returns an error when task not found' do
      put :update, params: { project_id: project.id, id: -1, task: { title: 'Updated Task' } }
      expect(response).to have_http_status(:not_found)
    end
  end
end
