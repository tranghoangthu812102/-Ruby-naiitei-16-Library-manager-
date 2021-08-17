class BooksController < ApplicationController
  load_and_authorize_resource
  before_action :find_book, except: %i(index new create)
  before_action :list_categories, only: %i(new create edit)
  before_action :require_admin, except: %i(index show)
  before_action :list_selected, only: :edit

  def index
    @books = Book.all.page params[:page]
  end

  def new
    @book = Book.new
    @book.book_categories.build
  end

  def create
    if create_book
      flash[:success] = t ".success"
      redirect_to books_path
    else
      flash.now[:danger] = t ".failed"
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if update_book
      flash[:success] = t ".edit_success"
      redirect_to @book
    else
      flash[:danger] = t ".edit_failed"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t ".success_delete"
      redirect_to books_path
    else
      flash[:danger] = t ".fail_delete"
      redirect_to @book
    end
  end

  private

  def book_params
    params.require(:book).permit Book::PERMITTED_FIELDS
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    if admin_page?
      redirect_to books_path, flash: {danger: t(".not_found")}
    else
      redirect_to user_books_path, flash: {danger: t(".not_found")}
    end
  end

  def create_book
    @book = Book.new book_params
    Book.transaction do
      author = Author.find_or_create_by name: params[:book][:author]
      @book.author = author
      @book.save!
    end
  rescue ActiveRecord::RecordInvalid
    add_error @book, @book.author
    @book.author = nil
    @book.book_categories.build
    list_categories
    nil
  end

  def update_book
    Book.transaction do
      author = Author.find_or_create_by! name: params[:book][:author]
      @book.author = author
      @book.update! book_params
    end
  rescue ActiveRecord::RecordInvalid
    @book.book_categories.build
    list_categories
    nil
  end

  def list_categories
    @categories = Category.pluck(:name, :id)
  end

  def add_error book, author
    author.errors.each do |error|
      book.errors.add("author #{error.attribute}", error.message)
    end
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:danger] = t "only_admin"
    redirect_to books_path
  end
end
