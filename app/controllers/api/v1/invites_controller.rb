# app/controllers/api/v1/invites_controller.rb
module Api
  module V1
    class InvitesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_project, except: [:check_invites]

      def create
        @invite = @project.invites.build(invite_params.merge(inviter: current_user))

        if @invite.save
          render json: @invite, status: :created
        else
          render json: { errors: @invite.errors.full_messages }, status: :unprocessable_entity
        end
      end        

      def accept
        @invite = Invite.find_by(id: params[:id], invitee_email: current_user.email)

        if @invite&.pending? && @invite.accept
          render json: { message: 'Invitation accepted' }, status: :ok
        else
          render json: { message: 'Invitation not found or already processed' }, status: :unprocessable_entity
        end
      end

      def reject
        @invite = Invite.find_by(id: params[:id], invitee_email: current_user.email)

        if @invite&.pending? && @invite.reject
          render json: { message: 'Invitation rejected' }, status: :ok
        else
          render json: { message: 'Invitation not found or already processed' }, status: :unprocessable_entity
        end
      end

      def check_invites
        render json: Invite.check_invites_for_user(current_user)
      end

      private

      def invite_params
        params.require(:invite).permit(:invitee_email)
      end

      def set_project
        @project = Project.find(params[:project_id])
      end
    end
  end
end
