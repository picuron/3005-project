require_relative '../../HelperLib/Helper.rb'
require_relative './CartController.rb' 
require_relative '../../Database/ClientQueries/RemoveBooksQueries.rb'

module Client
  # this is the same class as in controller, i just can't get the include path to work
  class Cart 
    def fetch_cart(cart_id)
      con = @session.db_connection_open
      cart = CartQueries.new(con).my_cart(cart_id)
      @session.db_connection_close(con)
      return cart
    end

    def print_cart(cart_records)
      cart_items = []
      cart_records.each do |book|
        cart_items << book
      end
      puts cart_items
    end
  end

  class RemoveBooks < Cart
    def initialize(session_object_in, cart_id)
      @session = session_object_in
      @cart = cart_id
      Helper.clear
      execute
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
        input = gets.chomp
        case input
        when ''
          break
        else 
          array_of_ISBNs_to_remove.push(input)
        end
      end
      array_of_ISBNs_to_remove.each do |isbn|
        con = @session.db_connection_open
        RemoveBooksQueries.new(con, @cart).remove_book_from_cart_by_isbn(isbn)
        @session.db_connection_close(con)
      end
    end


    #Main Method
    def execute
      puts "In Orders Execute"
      books_remove
      Helper.wait
    end 
  end
end