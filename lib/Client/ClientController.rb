module Client
  class ClientController
    def initalize(session_object_in)
      @session_object_in = session_object_in
      puts "\e[2J\e[f"
      message
      execute
    end

    private

    #Connection open and close methods
    # Open takes a Session Object, returns a Conneciton Object
    # Close tkaes a Connection Object, closes the connection
    def db_connection_open
      begin 
        connection_object = PG.connect( 
          :dbname => @session_object_in.db_name, 
          :user => @session_object_in.username, 
          :password => @session_object_in.password
        )
      return connection_object
      rescue PG::Error => e
        puts e.message 
      end 
    end

    def db_connection_close(connection_object_in)
      if connection_object_in 
        connection_object_in.close
      end
    end

    #menu options used in execute
    def main_menu_display 
      puts "\e[2J\e[f\nWelcome to the BookStore, What would you like to Do? \n"\
      "[1] - exit\n"\
      "[2] - get DB printout of all courses names\n"\
      "[3] - get DB printout of all course details\n"\
      "the rest of these are real and will be implemented\n"\
      "[4] - Browse Books\n"\
      "[5] - Search for Book\n"\
      "[6] - View Cart\n"\
      "[7] - View Orders\n"
    end

    def book_search_menu_display
      puts "\e[2J\e[f\nWhat would you like to seach By?\n"\
      "[1] - Book Name\n"\
      "[2] - Author Name\n"\
      "[3] - ISBN# \n"\
      "[4] - Genre \n"\
      "[5] - Return To Main Menu \n"
    end

    def cart_menu_display
      puts "\e[2J\e[f\nHere is everything in your Cart\n"\
      "...contents of cart...\n"\
      "What would you like to do?\n"\
      "[1] - Proceed to Checkout\n"\
      "[2] - Remove Books From Cart\n"\
      "[3] - Return To Main Menu \n"
    end

    def invalid_entry_display
      puts "\e[2J\e[f\nInvalid Input. Please try again and enter a valid number. \n"
    end

    def bye_ascii
      clear
      puts <<-'EOF'   
          __              _          
        |  _ \           | |
        | |_) |_   _  ___| |
        |  _ <| | | |/ _ \ |
        | |_) | |_| |  __/_|
        |____/ \__, |\___(_)
                __/ |       
              |___/        
      EOF
    end

    def message
      puts "In Client Controller"
    end

    #Helper Functions
    def wait 
      puts "\nPress enter to continue\n"
      input = gets.chomp
    end

    def clear
      puts "\e[2J\e[f\n"
    end

    def book_options_on_display_message(key, value)
      puts "\e[2J\e[fHere are all our books, after having performed a query for them\n"\
      "given the provided key #{key} and value #{value} \n"
      puts "\n-----Books-----\n"\
      "ISBN: 1234         Book: example1 \n"\
      "ISBN: 4321         Book: example2 \n"\
      "ISBN: 1324         Book: example3 \n"
      puts "Type in an ISBN to learn more about a book, or \'enter\' to exit"
      return ["1234", "4321", "1324"]
    end

    def query_for_books_by_param(key, value)
      while true
        book_options_array = book_options_on_display_message(key, value)
        input = gets.chomp
        if input == ''
          break
        elsif book_options_array.include? input
          clear
          puts "\nDisplaying all info about book with ISBN = #{input}\n"\
          "Would you like to add this book to your Cart? \n"\
          "[0] - No, Return to Book List\n"\
          "[1] - Yes, Add to Cart\n"
          input2 = gets.chomp
          case input2
          when '0'
            next
          when '1'
            clear 
            puts "Book with ISBN#: #{input} Has Been Added to Cart"
          end
        else 
          invalid_entry_display
        end 
        wait
      end
    end



    #Main Menu Case Functionality
    def main_menu_case_1
      bye_ascii
      exit
    end

    def main_menu_case_2
      connection_object = db_connection_open
      clear
      puts connection_object.exec('SELECT title FROM course').values
      db_connection_close(connection_object)
      wait
    end

    def main_menu_case_3
      clear
      connection_object = db_connection_open
      puts connection_object.exec('SELECT * FROM course').values
      db_connection_close(connection_object)
      wait
    end

    def main_menu_case_4
      query_for_books_by_param("", "")
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
          invalid_entry_display
        end 
      end
    end

    def main_menu_case_6
      while true
        cart_menu_display
        input = gets.chomp
        case input
        when '1'
          cart_menu_case_1
        when '2' 
          cart_menu_case_2
        when '3'
          break
        else
          invalid_entry_display
        end
      end
    end

    def main_menu_case_7
      puts "Viewing my order"
    end

    #Book Search Menu Case Functionality
    def book_search_menu_case_1
      clear
      puts "What Book Name would you like to search for?\n"
      book_name_input = gets.chomp
      puts "Here are all of books by book_name"
      query_for_books_by_param("book_name", "#{book_name_input}")
      wait
    end

    def book_search_menu_case_2
      clear
      puts "What Author Name would you like to search for?\n"
      author_name_input = gets.chomp
      puts "Here are all of the books by author name"
      query_for_books_by_param("author_name", "#{author_name_input}")
      wait
    end

    def book_search_menu_case_3
      clear
      puts "What ISBN would you like to search for?\n"
      isbn_input = gets.chomp
      puts "Here are all of the books by ISBN#"
      query_for_books_by_param("isbn", "#{isbn_input}")
      wait
    end

    def book_search_menu_case_4
      clear
      puts "What genre would you like to search for?\n"
      genre_input = gets.chomp
      puts "Here are all of the Books by genre"
      query_for_books_by_param("genre", "#{genre_input}")
      wait
    end

    #Cart Menu Case Functionality
    def cart_menu_case_1
      clear
      puts "\nProceeding To Checkout ....\n"
      puts "\nCheckout Complete, your order number is ###....\n"
      wait
    end

    def cart_menu_case_2
      array_of_ISBNs_to_remove = Array.new
      clear
      puts "Please Enter the ISBN for the book to want to remove, followed by enter.\n"\
      "Do not include spaces or commas\n"\
      "When Done, Press Enter Again to Submit\n"
      while true
        input = gets.chomp
        case input
        when ''
          break
        else 
          array_of_ISBNs_to_remove.push(input)
        end
      end

      clear
      puts "\nThe following books have been remved from your cart\n"
      puts array_of_ISBNs_to_remove
      wait
    end

    #Main Method, Give All Valid Client Interaction Options
    def execute
      while true
        main_menu_display
        input = gets.chomp
        case input
        when '1'
          main_menu_case_1
        when '2'
          main_menu_case_2
        when '3'
          main_menu_case_3
        when '4'
          main_menu_case_4
        when '5'
          main_menu_case_5
        when '6'
          main_menu_case_6
        when '7'
          main_menu_case_7
        else
          invalid_entry_display
        end
      end 
    end
  end
end
