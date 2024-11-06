# app/controllers/api/v1/projects_controller.rb
module Api
    module V1
      class ProjectsController < ApplicationController
        before_action :set_current_user, only: [:create]
  
        def index
          @projects = Project.all
          render json: @projects, status: :ok, layout: false
        end
  
        def create
          @project = Project.new(project_params)
          @project.user = current_user
  
          if @project.save
            render json: @project, status: :created
          else
            render json: { error: 'Unable to create project' }, status: :unprocessable_entity
          end
        end
  
        private
  
        def set_current_user
          @current_user = User.first  # Adjust this to your actual authentication logic
        end
  
        def current_user
          @current_user
        end
  
        def project_params
          params.require(:project).permit(:name, :description)
        end
      end
    end
end