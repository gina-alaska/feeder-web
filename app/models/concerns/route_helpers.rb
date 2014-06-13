module RouteHelpers
  def helpers
    Rails.application.routes.url_helpers
  end
end
