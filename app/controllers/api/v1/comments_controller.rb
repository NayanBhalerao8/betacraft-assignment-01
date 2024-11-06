# app/controllers/api/v1/comments_controller.rb
module Api
    module V1
      class CommentsController < ApplicationController
        before_action :set_current_user, only: [:create]
  
        def create
          @task = Task.find(params[:task_id])
          @comment = @task.comments.build(comment_params)
          @comment.user = current_user
  
          if @comment.save
            render json: @comment, status: :created
          else
            render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def set_current_user
          @current_user = User.first
        end
  
        def current_user
          @current_user
        end
  
        def comment_params
          params.require(:comment).permit(:content)
        end
      end
    end
  end
  