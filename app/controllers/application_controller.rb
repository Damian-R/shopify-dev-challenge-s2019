class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # Render a simple json message if a record is not found
  # (This could be more elegant with a front-end, but since this
  # is a small api-only app, I decided to keep it simple :D)
  def not_found
    render json: { message: 'record not found' }, status: :error
  end

  def no_route
    render json: { message: 'route not found' }, status: :error
  end

  include ApplicationHelper
end
