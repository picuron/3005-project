require 'pg'

module Database
  class InitDB
    
    def initalize
      create_user
    end

    private

    def create_user
      # system("brew services start postgresql")

      # system("brew services stop postgresql")

      begin

        con = PG.connect :dbname => 'testdb', :user => 'postgres', 
            :password => ''
    
        user = con.user
        db_name = con.db
        pswd = con.pass
        
        puts "User: #{user}"
        puts "Database name: #{db_name}"
        # puts "Password: #{pswd}" 
        
        sql = File.read("put the full url here")
        puts sql
        con.exec(sql)
        # with_db do |db|
        #   begin
        #     db.exec(sql)
        #   rescue PG::Error  => e
        #     puts e.message
        #   end
        # end
        
        rescue PG::Error => e
        
            puts e.message 
            
        ensure
    
        con.close if con
        
    end
    end
  end
end
