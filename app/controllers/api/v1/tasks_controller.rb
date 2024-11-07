module Api
  module V1
    class TasksController < ApplicationController
      
      before_action :set_current_user, only: [:create]

      def create
        @project = Project.find(params[:project_id])
        @task = @project.tasks.new(task_params.merge(user_id: current_user.id))  # Automatically set user_id
    
        if @task.save
          render json: @task, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end
      

      def update
        @project = Project.find_by(id: params[:project_id]) # Find project by ID
        @task = @project.tasks.find_by(id: params[:id])      # Find task by ID within the project
    
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

      def set_current_user
        @current_user = User.first  # For now, you can set a placeholder user
      end

      def current_user
        @current_user
      end

      def task_params
        params.require(:task).permit(:completed, :title, :description) # adjust fields as necessary
      end
    end
  end
end
