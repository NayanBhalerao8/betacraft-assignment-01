module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user!

      def create
        @task = Task.create_for_project_and_user(params[:project_id], current_user, task_params)
    
        if @task.persisted?  # Check if the task was successfully saved
          render json: @task, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity  # Return errors if task creation failed
        end
      end
      
      def update
        @task = Task.find_in_project(params[:id], params[:project_id])
    
        if @task.nil?
          render json: { error: 'Task not found' }, status: :not_found
        elsif @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def task_params
        params.require(:task).permit(:completed, :title, :description)
      end
    end
  end
end
