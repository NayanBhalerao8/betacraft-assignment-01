module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user!

      def index
        @projects = current_user.projects
        render json: @projects, status: :ok
      end

      def show
        @project = current_user.projects.find_by(id: params[:id])
        if @project
          render json: @project.to_json(include: { tasks: { include: :comments } })
        else
          render json: { error: 'Project not found' }, status: :not_found
        end
      end

      def create
        @project = current_user.projects.build(project_params)

        if @project.save
          render json: @project, status: :created
        else
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