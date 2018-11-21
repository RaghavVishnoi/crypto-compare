class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_default_timezone

  def set_default_timezone
  	Time.zone = DEFAULT_TIME_ZONE
  end
end
