class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find params[:id]
    @feed_items = Review.all.page params[:page]
    @review = Review.new
  end
end
