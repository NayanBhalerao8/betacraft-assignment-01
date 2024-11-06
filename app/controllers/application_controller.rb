class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_raven_context

  private

  def set_raven_context
    Sentry.set_user(id: session[:current_user_id])
    # Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
