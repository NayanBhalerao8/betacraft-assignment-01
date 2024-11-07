class HomeController < ApplicationController
  def index
    @invites = Invite.where(invitee_email: current_user.email)
    respond_to do |format|
      format.html
      format.any { head :not_found } # or :no_content, depending on what you prefer
    end
  end  
end
