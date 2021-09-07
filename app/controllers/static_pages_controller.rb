class StaticPagesController < ApplicationController
  def home
    @feed_items = Review.all.page params[:page] if user_signed_in?
    @review = Review.new
  end

  def help; end
end
