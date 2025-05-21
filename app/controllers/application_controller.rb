class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern
  add_flash_types :success, :error, :info, :warning
end
