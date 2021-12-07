require_relative '../HelperLib/Helper.rb'
require_relative '../Database/ClientQueries/SearchForBooksQueries.rb'


module Client
  class SearchForBooks
    def initialize(session_object_in)
      @session = session_object_in
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
      "[5] - Publisher \n"\
      "[6] - Return To Main Menu \n"
    end

    #Book Search Menu Case Functionality
    def search_by(key)
      Helper.clear
      puts "What #{key} would you like to search for?\n"
      value = gets.chomp
      puts "Here are our 5 closest matches to #{key}: #{value}"
      con = @session.db_connection_open
      books = SearchForBooksQueries.new(con, @cart).books_by_similar_value(key, value)
      @session.db_connection_close(con)
      books_array = []
      books.each do |book|
        books_array << book
      end
      puts books_array
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
          search_by('name')
        when '6'
          break
        else 
          Helper.invalid_entry_display
        end 
      end
    end

    #Main Method
    def execute
      search_controller
      Helper.wait
    end 
  end
end