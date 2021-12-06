require 'pg'
require 'io/console'
require_relative './PopulateDB'

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
      connection.exec('DROP TABLE IF EXISTS cart CASCADE')
      connection.exec('DROP TABLE IF EXISTS author_email CASCADE')
      connection.exec('DROP TABLE IF EXISTS owner_email CASCADE')
      connection.exec('DROP TABLE IF EXISTS publisher_email CASCADE')
      connection.exec('DROP TABLE IF EXISTS customer_email CASCADE')
      connection.exec('DROP TABLE IF EXISTS publisher_bank CASCADE')
      connection.exec('DROP TABLE IF EXISTS region CASCADE')
      connection.exec('DROP TABLE IF EXISTS address CASCADE')
      connection.exec('DROP TABLE IF EXISTS author CASCADE')
      connection.exec('DROP TABLE IF EXISTS publisher CASCADE')
      connection.exec('DROP TABLE IF EXISTS book CASCADE')
      connection.exec('DROP TABLE IF EXISTS owner CASCADE')
      connection.exec('DROP TABLE IF EXISTS customer CASCADE')
      connection.exec('DROP TABLE IF EXISTS reports CASCADE')
      connection.exec('DROP TABLE IF EXISTS checkout CASCADE')
      connection.exec('DROP TABLE IF EXISTS orders CASCADE')
      connection.exec('DROP TABLE IF EXISTS cart_books CASCADE')
      connection.exec('DROP TABLE IF EXISTS author_books CASCADE')
      connection.exec('DROP TABLE IF EXISTS author_phone_number CASCADE')
      connection.exec('DROP TABLE IF EXISTS owner_phone_number CASCADE')
      connection.exec('DROP TABLE IF EXISTS customer_phone_number CASCADE')
      connection.exec('DROP TABLE IF EXISTS publisher_phone_number CASCADE')
      puts "--- All Tables Dropped ---"
    end

    def generate_all_tables(connection)
      puts "--- Generating All Tables ---"
      connection.exec(File.read("./Database/SQL/realDDL.sql"))
      puts "--- All Tables Generated ---"
    end

    # def populate_all_tables(connection)
    #   puts "--- Populating All Tables ---"
    #   connection.exec(File.read("./Database/SQL/realRelationsInsert.sql"))
    #   puts " we have no data yet "
    #   puts "--- All Tables Populated ---"
    # end
    
    def init_db(db_session)
      begin 
        con = db_connection_open(db_session)

        drop_all_tables(con)
        generate_all_tables(con)
        #populate_all_tables(con)
        PopulateDB.new.initalize(con)

      rescue PG::Error => e
        puts e.message 
      ensure
        if con 
          con.close
        end
      end
    end

    def db_connection_open(db_session)
      begin 
        connectionObject = PG.connect( 
          :dbname => db_session.db_name, 
          :user => db_session.username, 
          :password => db_session.password
        )
      return connectionObject
      rescue PG::Error => e
        puts e.message 
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

          db_session = DBSession.new(db_name, username, password)

          con = db_connection_open(db_session)

          if db_session
            emptySession = false 
          end

          puts "\e[2J\e[fDatabase connection success!"
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
