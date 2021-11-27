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
          "[3] - get DB printout of all course details\n"

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
