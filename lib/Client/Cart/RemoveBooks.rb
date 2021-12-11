require_relative '../../HelperLib/Helper.rb'
require_relative './CartController.rb'
require_relative '../../Database/ClientQueries/RemoveBooksQueries.rb'

module Client
  class RemoveBooks
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

    def fetch_cart(cart_id)
      con = @session.db_connection_open
      cart = CartQueries.new(con).my_cart(cart_id)
      @session.db_connection_close(con)
      return cart
    end

    def fetch_book(isbn)
      con = @session.db_connection_open
      book = BrowseBooksQueries.new(con).book_by_isbn(isbn)
      @session.db_connection_close(con)
      return book
    end

    def print_cart(cart_records)
      cart_items = []
      cart_records.each do |book|
        cart_items << book
      end
      puts cart_items
    end

    private
    # Helper Functions
    def books_remove
      array_of_ISBNs_to_remove = Array.new
      Helper.clear
      puts "\nHere is everything in your Cart\n\n"
      print_cart(fetch_cart(@cart))
      puts "\nPlease Enter the ISBN for the book to want to remove, followed by enter."
      puts "When Done, Press Enter Again to Submit\n"
      while true
        isbn = gets.chomp
        if isbn == ''
          break
        elsif isbn.length != 9
          puts "Sorry, isbn's should be 9 characters long"
        elsif isbn.to_i == 0
          puts "Sorry, isbn's are only numerical"
        elsif fetch_book(isbn).values.length == 0
          puts "Sorry, can't find that one."
        else
          array_of_ISBNs_to_remove.push(isbn)
        end
      end
      array_of_ISBNs_to_remove.each do |e|
        con = @session.db_connection_open
        RemoveBooksQueries.new(con, @cart).remove_book_from_cart_by_isbn(e)
        @session.db_connection_close(con)
      end
    end


    #Main Method
    def execute
      books_remove
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end