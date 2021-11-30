require_relative '../HelperLib/Helper.rb'
require_relative '../HelperLib/QueryHelp/BooksQueryHelper.rb'

module Client
  class SearchForBooks
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      execute
    end

    private
    # Helper Functions
    def book_search_menu_display
      Helper.clear
      puts "\nWhat would you like to seach By?\n"\
      "[1] - Book Name\n"\
      "[2] - Author Name\n"\
      "[3] - ISBN# \n"\
      "[4] - Genre \n"\
      "[5] - Return To Main Menu \n"
    end

    #Book Search Menu Case Functionality
    def book_search_menu_case_1
      Helper.clear
      puts "What Book Name would you like to search for?\n"
      book_name_input = gets.chomp
      puts "Here are all of books by book_name"
      Helper::BooksQueryHelper.new(@db).query_for_books_by_param("book_name", "#{book_name_input}")
      Helper.wait
    end

    def book_search_menu_case_2
      Helper.clear
      puts "What Author Name would you like to search for?\n"
      author_name_input = gets.chomp
      puts "Here are all of the books by author name"
      Helper::BooksQueryHelper.new(@db).query_for_books_by_param("author_name", "#{author_name_input}")
      Helper.wait
    end

    def book_search_menu_case_3
      Helper.clear
      puts "What ISBN would you like to search for?\n"
      isbn_input = gets.chomp
      puts "Here are all of the books by ISBN#"
      Helper::BooksQueryHelper.new(@db).query_for_books_by_param("isbn", "#{isbn_input}")
      Helper.wait
    end

    def book_search_menu_case_4
      Helper.clear
      puts "What genre would you like to search for?\n"
      genre_input = gets.chomp
      puts "Here are all of the Books by genre"
      Helper::BooksQueryHelper.new(@db).query_for_books_by_param("genre", "#{genre_input}")
      Helper.wait
    end

    def main_menu_case_5
      while true
        book_search_menu_display
        input = gets.chomp
        case input
        when '1'
          book_search_menu_case_1
        when '2' 
          book_search_menu_case_2
        when '3'
          book_search_menu_case_3
        when '4'
          book_search_menu_case_4
        when '5'
          break
        else 
          Helper.invalid_entry_display
        end 
      end
    end

    #Main Method
    def execute
      puts "In SearchBooks Execute"
      Helper.wait
      main_menu_case_5
      Helper.wait
    end 
  end
end