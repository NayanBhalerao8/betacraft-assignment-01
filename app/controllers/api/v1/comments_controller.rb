module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_task

      # Add this to fetch all comments for the task
      def index
        render json: @task.comments
      end

      def create
        @comment = Comment.create_for_task(@task, current_user, comment_params[:content])
      
        if @comment.persisted?
          render json: @comment, status: :created
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end      

      private

      def set_task
        @task = Task.find(params[:task_id])
      end

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
