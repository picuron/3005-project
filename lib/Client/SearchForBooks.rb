require_relative '../HelperLib/Helper.rb'
require_relative '../Database/ClientQueries/SearchForBooksQueries.rb'


module Client
  class SearchForBooks
    attr_accessor :cart
    attr_accessor :session
    attr_accessor :user
    attr_accessor :state
    def initialize(session, cart, user)
      @session = session
      @cart = cart
      @user = user
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
      Helper.clear
      execute
    end

    private
    # Helper Functions
    def book_search_menu_display
      Helper.clear
      puts "\nWhat would you like to search By?\n"\
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
    end

    #FROM HERE DOWN TO MARKER IS DUPLICATED IN BROWSE BOOKS
    #PUT THESE FUNCTIONS In ANOTHER FILE
    def show_book_and_authors(book, authors)
      puts "Title: ".ljust(30) + "#{book.values[0][0]}"
      puts "ISBN: ".ljust(30) + "#{book.values[0][1]}"
      puts "Genre: ".ljust(30) + "#{book.values[0][2]}"
      puts "Number of Pages: ".ljust(30) + "#{book.values[0][3]}"
      puts "Price: ".ljust(30) + "$#{book.values[0][4]}"
      puts "Number in Stock: ".ljust(30) + "#{book.values[0][5]}"
      puts "Number Sold: ".ljust(30) + "#{book.values[0][6]}"
      puts "Publsiher Name: ".ljust(30) + "#{book.values[0][7]}"
      puts "Author(s): ".ljust(30)
      authors.values.each {|first, last| puts "#{first} #{last}".rjust(30)}
    end

    def add_to_cart_by_isbn(isbn)
      Helper.clear
      con = @session.db_connection_open
      @cart = BrowseBooksQueries.new(con).add_to_cart(isbn, @cart)
      @session.db_connection_close(con)
      puts "Book with ISBN#: #{isbn} Has Been Added to Cart"
      Helper.wait
    end

    def fetch_book(isbn)
      con = @session.db_connection_open
      book = BrowseBooksQueries.new(con).book_by_isbn(isbn)
      @session.db_connection_close(con)
      return book
    end

    def fetch_authors(isbn)
      con = @session.db_connection_open
      authors = BrowseBooksQueries.new(con).authors_of_book(isbn)
      @session.db_connection_close(con)
      return authors
    end

    def see_book_details(book, authors)
      Helper.clear
      show_book_and_authors(book, authors)
      choice = nil
      until (choice == '1' || choice == '0') do
        puts "\nWould you like to add this book to your Cart? \n"\
        "[0] - No, Return to Book List\n"\
        "[1] - Yes, Add to Cart\n"
        choice = gets.chomp
      end
      return choice
    end

    def choose_a_book
      puts "\nEnter an ISBN to see more about a book, or press 'enter' to go back to the menu."
      isbn = gets.chomp
      if isbn == ''
        return false
      elsif isbn.length != 9
        puts "Sorry, isbn's should be 9 characters long"
        choose_a_book
      elsif isbn.to_i == 0
        puts "Sorry, isbn's are only numerical"
        choose_a_book
      else
        book = fetch_book(isbn)
        if book.values.length == 0
          puts "Sorry, can't find that one."
          choose_a_book
        else
          authors = fetch_authors(isbn)
          choice = see_book_details(book, authors)
          case choice
            when '0'
              true
            when '1'
              add_to_cart_by_isbn(isbn)
          end
        end
      end
    end
    #BOTTOM MARKER OF DUPLICATE CODE

    def search_controller
      while true
        book_search_menu_display
        input = gets.chomp
        case input
        when '1'
          search_by('title')
          choose_a_book
        when '2'
          search_by('author_name')
          choose_a_book
        when '3'
          search_by('isbn')
          choose_a_book
        when '4'
          search_by('genre')
          choose_a_book
        when '5'
          search_by('name')
          choose_a_book
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
      #updates the state as we exit file
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end