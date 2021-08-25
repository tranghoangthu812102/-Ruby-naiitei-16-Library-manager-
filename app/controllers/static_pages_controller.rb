class StaticPagesController < ApplicationController
  def home
    @feed_items = Review.all.page params[:page] if logged_in?
    @review = Review.new
  end

  def help; end
end
