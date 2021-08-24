module BooksHelper
  def list_selected
    @list_selected = ["", 0]
    @book.category_ids.each do |category_id|
      element = Category.find_by id: category_id
      @list_selected += [element.name, element.id]
    end
  end
end
