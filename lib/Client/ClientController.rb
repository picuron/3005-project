module Client
  class ClientController
      
      def initalize(session_object_in)
        @session_object_in = session_object_in

        puts "\e[2J\e[f"
        message
        execute
      end

      private

      #takes in a sessionObject, returns a connectionObject
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

      #takes in a connectionObject, closes the connection
      def db_connection_close(connection_object_in)
        if connection_object_in 
          connection_object_in.close
        end
      end

      #main control, takes sessionObject, loops through client options
      def execute
        while true
          puts "\nWelcome to the BookStore, What would you like to Do? \n"\
          "[1] - exit\n"\
          "[2] - get DB printout of all courses names\n"\
          "[3] - get DB printout of all course details\n"\
          "the rest of these are real and will be implemented\n"\
          "[4] - Browse Books\n"\
          "[5] - Search for Book\n"\
          "[6] - View Cart\n"\
          "[7] - View Orders\n"

          input = gets.chomp
          case input
          when '1'
            bye_ascii
            exit
          when '2'
            connection_object = db_connection_open
            puts connection_object.exec('SELECT title FROM course').values
            db_connection_close(connection_object)
          when '3'
            connection_object = db_connection_open
            puts connection_object.exec('SELECT * FROM course').values
            db_connection_close(connection_object)
          when '4'
            puts "Here are all our books\n"
          when '5'
            while true
            puts "What would you like to seach By?\n"\
            "[1] - Book Name\n"\
            "[2] - Author Name\n"\
            "[3] - ISBN# \n"\
            "[4] - Genre \n"
            "[5] - Return To Main Menu \n"

            input = gets.chomp
            case input
            when '1'
              puts "Here are all of books by book_name"
            when '2' 
              puts "Here are all of the books by author name"
            when '3'
              puts "Here are all of the books by ISBN#"
            when '4'
              puts "Here are all of the Books by genre"
            when '5'
              exit
            else 
              puts "\nInvalid Input. Please try again and enter a valid number. \n"
            end
          when '6'
            while true
            puts "Here is everything in your Cart\n"\
            "...contents of cart...\n"\
            "What would you like to do?\n"\
            "[1] - Proceed to Checkout\n"\
            "[2] - Remove Books From Cart\n"\
            "[3] - Return To Main Menu \n"

            input = gets.chomp
            case input
            when '1'
              puts "Proceeding To Checkout ...."
              exit
            when '2' 
              array_of_ISBNs_to_remove = []
              puts "Please Enter the ISBN for the book to want to remove, followed by enter.\n"\
              "Do not include spaces or commas\n"\
              "Enter \'0\' and Press Submit when you are done\n"\
              while true
                input = gets.chomp
                case input
                when '0'
                  exit
                else 
                  array_of_ISBNs_to_remove.add(input)
                end
            when '3'
              exit
            else
              puts "\nInvalid Input. Please try again and enter a valid number. \n"
            end
          else
            puts "\nInvalid Input. Please try again and enter a valid number. \n"
          end
        end 
      end

      def bye_ascii
        puts "\e[2J\e[f"
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
  end
end
