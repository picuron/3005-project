module Client
  class ClientController
      
      def initalize(sessionObjectIn)
        message
        main(sessionObjectIn)
      end

      #takes in a sessionObject, returns a connectionObject
      def dbConnectionOpen(sessionObjectIn)
        begin 
          connectionObject = PG.connect( 
            :dbname => sessionObjectIn.db_name, 
            :user => sessionObjectIn.username, 
            :password => sessionObjectIn.password
          )
        return connectionObject
        rescue PG::Error => e
          puts e.message 
        end 
      end

      #takes in a connectionObject, closes the connection
      def dbConnectionClose(connectionObjectIn)
        if connectionObjectIn 
          connectionObjectIn.close
        end
      end

      #main control, takes sessionObject, loops through client options
      def main(sessionObjectIn)
        loop do
          puts "Welcome to the BookStore, What would you like to Do? \n"\
          "[1] - loop again\n"\
          "[2] - exit\n"\
          "[3] - get DB printout of all courses names\n"\
          "[4] - get DB printout of all course details\n"
          input = gets.chomp
          if input == "1"
            puts "OK\n"
          elsif input == "3"
            connectionObject = dbConnectionOpen(sessionObjectIn)
            puts connectionObject.exec('SELECT title FROM course').values
            dbConnectionClose(connectionObject)
          elsif input == "4"
            connectionObject = dbConnectionOpen(sessionObjectIn)
            puts connectionObject.exec('SELECT * FROM course').values
            dbConnectionClose(connectionObject)
          else
            break
          end
        end 
      end

      private

      def message
        puts "In Client Controller"
      end
  end
end
  