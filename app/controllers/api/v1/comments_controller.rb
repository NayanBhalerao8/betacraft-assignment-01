module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_project
      before_action :set_task

      # Add this to fetch all comments for the task
      def index
        comments = @task.comments
        render json: comments
      end

      def create
        @comment = @task.comments.new(comment_params)
        @comment.user = current_user

        if @comment.save
          render json: @comment, status: :created
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_project
        @project = Project.find(params[:project_id])
      end

      def set_task
        @task = Task.find(params[:task_id])
      end

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
