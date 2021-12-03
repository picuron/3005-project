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
    def search_by(key)
      Helper.clear
      puts "What #{key} would you like to search for?\n"
      value = gets.chomp
      puts "Here are all of books with #{key} #{value}"
      Helper::BooksQueryHelper.new(@db).query_for_books_by_param("#{key}", "#{value}")
      Helper.wait
    end

    def search_controller
      while true
        book_search_menu_display
        input = gets.chomp
        case input
        when '1'
          search_by('title')
        when '2' 
          search_by('author_name')
        when '3'
          search_by('ISBN')
        when '4'
          search_by('genre')
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
      search_controller
      Helper.wait
    end 
  end
end