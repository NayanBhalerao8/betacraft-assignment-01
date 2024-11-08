require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  include Devise::Test::ControllerHelpers # Include Devise helpers for controller specs

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    sign_in user # Assumes Devise is being used for authentication
  end

  def json
    JSON.parse(response.body)
  end

  describe 'GET #index' do
    it 'returns a list of projects' do
      create(:project, user: user) # Create a second project to ensure two projects
      get :index
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(1) # Expect two projects
    end
  end

  describe 'GET #show' do
    it 'returns a single project' do
      get :show, params: { id: project.id }
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(project.id)
    end
  end

  describe 'POST #create' do
    it 'returns errors when project creation fails' do
        post :create, params: { project: { name: '', description: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']).to include("Name can't be blank") # Assuming validation error on 'name'
    end
  end

end
