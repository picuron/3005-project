require_relative '../HelperLib/Helper.rb'

module Owner
  class RemoveBook
    def initialize(session_object_in)
      @session_object_in = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In RemoveBook"
    end

    def display_isbns
      con = @session_object_in.db_connection_open
      books = con.exec("SELECT isbn, title FROM book")
      @session_object_in.db_connection_close(con)
      
      books.each do |book|
        puts "ISBN: " + book["isbn"] + " | Title: " + book["title"]
      end 
    end

    def valid_isbn(isbn)
      con = @session_object_in.db_connection_open
      book_statement = "SELECT COUNT(*) FROM book WHERE isbn=$1"
      query_result = con.exec_params(book_statement, [isbn])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return true
      end
      false
    end

    #Main Method
    def execute
      display_isbns
      removal_isbn = ""
      while true
        puts "What is the ISBN of the book you wish to remove?"
        removal_isbn = gets.chomp
        break if valid_isbn(removal_isbn)

        puts "That isbn was invalid. Try again.\n\n"
      end
      
      con = @session_object_in.db_connection_open
      removal_statment = "DELETE FROM book WHERE isbn = $1"
      query_result = con.exec_params(removal_statment, [removal_isbn])
      @session_object_in.db_connection_close(con)

      puts "That ISBN has been removed!"
      Helper.wait
    end 
  end
end
  