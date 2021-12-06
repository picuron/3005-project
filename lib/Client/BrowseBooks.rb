require_relative '../HelperLib/Helper.rb'
require_relative '../Database/ClientQueries/BrowseBooksQueries.rb'

module Client
  class BrowseBooks
    attr_accessor :cart
    def initialize(session_object_in, cart)
      @session = session_object_in
      @cart = cart
      Helper.clear
      execute
    end

    private
    def book_options_on_display_message(key, value)
      #fetch books by key and value
      con = @session.db_connection_open
      books = BrowseBooksQueries.new(con).books_by_key_value(key, value)
      @session.db_connection_close(con)
      #generate array and return
      books_array = []
      books.each do |book|
        books_array << book
      end
      return books_array
    end

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

    def books_by_key_message(key, value)
      Helper.clear
      puts "Here are all our books"
      if(key != "" && value != "")
        puts "Where #{key}: #{value} \n"
      end
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

    def query_for_books_by_param(key, value)
      books_by_key_message(key, value)
      books_array = book_options_on_display_message(key, value)
      puts books_array
    end

    def choose_a_book
      puts "\nEnter an ISBN to see more about a book, or press 'enter' to go back to the menu."
      isbn = gets.chomp
      if isbn == ''
        return false
      else
        book = fetch_book(isbn)
        authors = fetch_authors(isbn)
        Helper.clear
        if book != nil
          show_book_and_authors(book, authors)
          puts "\nWould you like to add this book to your Cart? \n"\
          "[0] - No, Return to Book List\n"\
          "[1] - Yes, Add to Cart\n"
          choice = gets.chomp
          case choice
          when '0'
            return true
          when '1'
            add_to_cart_by_isbn(isbn)
          end
        else
          puts "Sorry, that isbn cannot be found..."
        end
      end
    end


    #Main Method
    def execute
      return_to_book_display = true
      while return_to_book_display  
        query_for_books_by_param("", "")
        return_to_book_display = choose_a_book
      end
      #We will return our cart instance, because it may have been updated 
      #while in this menu, we will reset the cart_id instance var at the 
      #Client controller level. 
      return @cart
    end 
  end
end