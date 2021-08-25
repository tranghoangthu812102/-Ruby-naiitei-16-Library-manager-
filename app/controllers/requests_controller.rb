class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :check_login, only: %i(create success)
  before_action :check_borrowed_book, only: :create
  before_action :load_book, only: :create

  def index
    if admin_page?
      @requests = Request.page params[:page]
      return
    end
    @requests = current_user.requests.page params[:page]
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params.merge(book: @book,
                                                 user: current_user,
                                                 date_start: Time.current)
    if @request.save
      redirect_to success_path
    else
      flash.now[:danger] = t ".save_error"
      render :new
    end
  end

  def success; end

  def update
    @request = Request.find_by book_id: params[:book_id],
                               user_id: params[:user_id]
    @request.returned!
    redirect_to requests_url
  end

  private

  def request_params
    params.require(:request).permit :date_end
  end

  def check_login
    redirect_to home_path, flash: {danger: t(".please_login")} unless logged_in?
  end

  def check_borrowed_book
    check_request = Request.find_by(book_id: params[:book_id],
                               user_id: current_user.id)
    return if check_request.nil? || check_request.returned?

    redirect_to user_books_path, flash: {danger: t(".already_borrowed")}
  end

  def load_book
    @book = Book.find params[:book_id]
  end
end
