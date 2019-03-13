class UsersController < ApplicationController
  skip_before_action :set_user, only: :create

  def show
    render json: @current_user
  end

  def create
    user = User.new user_params
    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update user_params
      render json: @current_user, status: :ok
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
