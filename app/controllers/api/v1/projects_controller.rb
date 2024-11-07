module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_current_user, only: [:create]

      def index
        @projects = Project.all
        render json: @projects, status: :ok
      end
    
      def show
        @project = Project.includes(tasks: :comments).find(params[:id])
        render json: @project.to_json(include: { tasks: { include: :comments } })
      end
      

      def new
        @project = Project.new
      end
    
      def create
        @project = Project.new(project_params)
        @project.user = current_user
    
        if @project.save
          redirect_to @project, notice: 'Project created successfully.'
        else
          render :new
        end
      end
    
      private
    
      def set_current_user
          # Assign the first user from the database to current_user
          @current_user = current_user
      end
        
      def current_user
          @current_user
      end

      def project_params
        params.require(:project).permit(:title, :description)
      end
    end
  end
end
  