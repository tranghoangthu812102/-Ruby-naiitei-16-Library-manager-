class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find params[:id]
  end
end
