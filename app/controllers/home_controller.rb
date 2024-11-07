class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.any { head :not_found } # or :no_content, depending on what you prefer
    end
  end  
end
