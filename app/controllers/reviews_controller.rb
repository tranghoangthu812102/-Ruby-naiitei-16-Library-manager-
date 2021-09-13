class ReviewsController < ApplicationController
  before_action :find_reviewable
  before_action :find_review, only: %i(edit update)

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new review_params.merge(
      reviewable_id: params[:book_id],
      reviewable_type: Book.name
    )
    if @review.save
      redirect_to books_path, flash: {success: t(".success")}
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit; end

  def update
    respond_to do |format|
      format.html do
        if @review.update review_params
          flash[:success] = t(".edit_success")
          redirect_to user_books_show_path(@review.book)
        else
          flash[:danger] = t(".edit_fail")
          redirect_to books_path
        end
      end
    end
  end

  def destroy
    @review = Review.find params[:id]
    if @review.destroy
      redirect_to books_path, flash: {success: t(".delete")}
    else
      redirect_to books_path, flash: {danger: t(".wrong")}
    end
  end

  private

  def review_params
    params.require(:review).permit Review::PERMITTED
  end

  def find_reviewable
    if params[:user_id].present?
      @reviewable = User.find_by(id: params[:user_id])
    elsif params[:book_id].present?
      @reviewable = Book.find_by(id: params[:book_id])
    end
  end

  def find_review
    @review = Review.find_by id: params[:id]
    return if @review

    flash[:danger] = t ".not_found"
    redirect_to books_path
  end
end
