module Helper
  class HelperConnection
    def initialize(session_object_in)
      @session_object_in = session_object_in
    end
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
  end


  # Module Helper MEthods
  def wait 
    puts "\nPress enter to continue\n"
    input = gets.chomp
  end
  module_function :wait

  def clear
    puts "\e[2J\e[f"
  end
  module_function :clear

  def invalid_entry_display
    Helper.clear
    puts "\nInvalid Input. Please try again and enter a valid number. \n"
  end
  module_function :invalid_entry_display

  def bye_ascii
    Helper.clear
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
  module_function :bye_ascii


end