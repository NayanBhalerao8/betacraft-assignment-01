# app/controllers/api/v1/invites_controller.rb
module Api
    module V1
      class InvitesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_project, except: [:check_invites]
  
        def create
          @invite = @project.invites.new(invite_params)
          @invite.inviter = current_user
  
          if @invite.save
            render json: @invite, status: :created
          else
            render json: { errors: @invite.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        def accept
          @invite = Invite.find_by(id: params[:id], invitee_email: current_user.email)
  
          if @invite && @invite.status == 'pending'
            @invite.accept
            render json: { message: 'Invitation accepted' }, status: :ok
          else
            render json: { message: 'Invitation not found or already accepted/rejected' }, status: :unprocessable_entity
          end
        end
  
        def reject
          @invite = Invite.find_by(id: params[:id], invitee_email: current_user.email)
  
          if @invite && @invite.status == 'pending'
            @invite.reject
            render json: { message: 'Invitation rejected' }, status: :ok
          else
            render json: { message: 'Invitation not found or already accepted/rejected' }, status: :unprocessable_entity
          end
        end
  
        def check_invites
          # Get the invites for the current user
          @invites = Invite.where(invitee_email: current_user.email)
          # Map through each invite and fetch the project_name and user_email
          invites_with_project_and_user = @invites.map do |invite|
            project_name = invite.project&.name # Fetch project name using project_id
            user_email = invite.user&.email     # Fetch user email using user_id

            # Returning the invite data along with project name and user email
            invite.attributes.merge(
              project_name: project_name,
              user_email: user_email
            )
          end

          # Returning the modified invites with project and user data as JSON
          render json: invites_with_project_and_user
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
  