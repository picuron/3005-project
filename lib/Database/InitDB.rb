require 'pg'
require 'io/console'

module Database
  class InitDB
    class DBSession
      attr_accessor :db_name
      attr_accessor :username
      attr_accessor :password
      def initialize(db_name_in, username_in, password_in)
        @db_name = db_name_in
        @username = username_in
        @password = password_in
      end
    end
    
    def connect
      db_session = connect_to_db
      if should_init_db?
        init_db(db_session)
      end
      return db_session
    end

    private
    def should_init_db?
      puts "Would you like to initalize the database? (Y/N)"
      while user_input = gets.chomp 
        case user_input
        when "Y"
          return true
          break 
        when "N"
          return false
          break 
        else
          puts "Invalid Input. Enter Y or N."
        end
      end
    end

    def drop_all_tables(connection)
      puts "--- Dropping All Tables ---"
      connection.exec('DROP TABLE IF EXISTS classroom CASCADE')
      connection.exec('DROP TABLE IF EXISTS department CASCADE')
      connection.exec('DROP TABLE IF EXISTS course CASCADE')
      connection.exec('DROP TABLE IF EXISTS instructor CASCADE')
      connection.exec('DROP TABLE IF EXISTS section CASCADE')
      connection.exec('DROP TABLE IF EXISTS teaches CASCADE')
      connection.exec('DROP TABLE IF EXISTS student CASCADE')
      connection.exec('DROP TABLE IF EXISTS takes CASCADE')
      connection.exec('DROP TABLE IF EXISTS advisor CASCADE')
      connection.exec('DROP TABLE IF EXISTS time_slot CASCADE')
      connection.exec('DROP TABLE IF EXISTS prereq CASCADE')
      connection.exec('DROP TABLE IF EXISTS person CASCADE')
      puts "--- All Tables Dropped ---"
    end

    def generate_all_tables(connection)
      puts "--- Generating All Tables ---"
      connection.exec(File.read("/Users/joshuakline/Desktop/Fall_2021/COMP3005/Project/src/3005-project/lib/Database/SQL/DDL.sql"))
      puts "--- All Tables Generated ---"
    end

    def populate_all_tables(connection)
      puts "--- Populating All Tables ---"
      connection.exec(File.read("/Users/joshuakline/Desktop/Fall_2021/COMP3005/Project/src/3005-project/lib/Database/SQL/RelationsInsert.sql"))
      puts "--- All Tables Populated ---"
    end

    def init_db(db_session)
      begin 
        con = PG.connect( 
          :dbname => db_session.db_name, 
          :user => db_session.username, 
          :password => db_session.password
        )

        drop_all_tables(con)
        generate_all_tables(con)
        populate_all_tables(con)

      rescue PG::Error => e
        puts e.message 
      ensure
        if con 
          con.close
        end
      end
    end

    def connect_to_db
      emptySession = true
      while emptySession
        begin
          puts "DB name: "
          db_name = gets.chomp
          puts "Postgres Username: "
          username = gets.chomp
          puts "Password: "

          password = STDIN.noecho(&:gets).chomp
          con = PG.connect( 
            :dbname => db_name, 
            :user => username, 
            :password => password
          )

          db_session = DBSession.new(db_name, username, password)
          if db_session
            emtySession = false 
          end
          return db_session
          rescue PG::Error => e
              puts "\nSorry, but there is no match for that db_name, user_name, and password.\n"\
              "The following error message was generated: #{e.message} \n Please Try Again.\n\n"
              next
          ensure
            if con 
              con.close
            end
          end
      end
    end
  end
end
