class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_raven_context

  private

  def json_request?
    request.format.json?
  end

  def set_raven_context
    Sentry.set_user(id: session[:current_user_id])
    # Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
