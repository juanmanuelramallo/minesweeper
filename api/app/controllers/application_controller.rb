class ApplicationController < ActionController::API
  before_action :set_user

  private

  def set_user
    @current_user = User.find_by! uuid: request.headers["X-Minesweeper-User-Uuid"]
  end
end
