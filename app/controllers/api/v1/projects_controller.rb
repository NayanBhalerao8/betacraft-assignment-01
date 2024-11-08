module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user!

      def index
        @projects = current_user.projects
        render json: @projects, status: :ok
      end
    
      def show
        @project = current_user.projects.includes(tasks: :comments).find(params[:id])
        render json: @project.to_json(include: { tasks: { include: :comments } })
      end

      def create
        @project = current_user.projects.build(project_params)

        if @project.save
          # Render the newly created project as JSON
          render json: @project, status: :created
        else
          # Return errors with 422 status if validation fails
          render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
