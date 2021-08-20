class UsersController < ApplicationController
  load_and_authorize_resource
  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome_to_library!"
      redirect_to @user
    else
      flash[:danger] = t ".registration_failed"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::PERMITTED_FIELDS
  end
end
