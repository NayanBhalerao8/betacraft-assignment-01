# app/controllers/api/v1/tasks_controller.rb
module Api
    module V1
      class TasksController < ApplicationController
        before_action :set_current_user, only: [:create]
  
        def create
            @project = Project.find(params[:project_id])
            @task = @project.tasks.build(task_params)
            @task.user = current_user
          
            if @task.save
              render json: @task, status: :created
            else
              render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
            end
        end
          
  
        def update
          @task = Task.find(params[:id])
          if @task.update(task_params)
            render json: @task, status: :ok
          else
            render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def set_current_user
          @current_user = User.first
        end
  
        def current_user
          @current_user
        end
  
        def task_params
            params.require(:task).permit(:title, :completed, :description, :project_id)
          end          
      end
    end
  end
  