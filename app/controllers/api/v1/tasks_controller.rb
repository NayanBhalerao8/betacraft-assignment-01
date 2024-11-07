module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user!  # Ensures user is authenticated

      def create
        @project = Project.find(params[:project_id])
        @task = @project.tasks.new(task_params.merge(user_id: current_user.id))  # Automatically set user_id from current_user
    
        if @task.save
          render json: @task, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end
      
      def update
        @project = Project.find_by(id: params[:project_id])  # Find project by ID
        @task = @project.tasks.find_by(id: params[:id])       # Find task by ID within the project
    
        if @task.nil?
          render json: { error: 'Task not found' }, status: :not_found
          return
        end
    
        if @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def task_params
        params.require(:task).permit(:completed, :title, :description)  # Adjust fields as necessary
      end
    end
  end
end
