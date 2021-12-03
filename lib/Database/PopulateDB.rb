require 'pg'
require 'io/console'
require 'faker'

module Database
  class PopulateDB
    def initalize(con)
      @con = con
      execute
    end

    private

    def execute
      puts "INSERTING INTO DB"
      @con.exec("INSERT INTO owner_email VALUES ('ahmedelroby@gmail.com', 'Ahmed', 'ElRoby')")
      @con.exec("INSERT INTO owner (email_address, username, password) VALUES('ahmedelroby@gmail.com', 'ElRoby', 'COMP3005')")
    end
  end
end