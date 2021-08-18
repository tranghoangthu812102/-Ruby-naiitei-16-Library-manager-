class BooksController < ApplicationController
  load_and_authorize_resource
  before_action :find_book, except: %i(index new create)
  before_action :list_categories, only: %i(new)

  def index
    @books = Book.all.page params[:page]
  end

  def show; end

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

  def list_categories
    @categories = Category.pluck(:name, :id)
  end

  def add_error book, author
    author.errors.each do |error|
      book.errors.add("author #{error.attribute}", error.message)
    end
  end
end
