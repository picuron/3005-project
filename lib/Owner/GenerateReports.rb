require_relative '../HelperLib/Helper.rb'

module Owner
  class GenerateReports
    def initialize(session_object_in, login_session)
      @session_object_in = session_object_in
      @login_session = login_session
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In Generate Reports"
    end

    def generate_sales_vs_cost
      puts "What is the day today?"
      day = gets.chomp
      puts "What is the month today (number)"
      month = gets.chomp
      puts "What is the year today?"
      year = gets.chomp
      con = @session_object_in.db_connection_open
      sales = con.exec("SELECT SUM(price*num_sold) FROM book").values[0][0].to_f
      cost = con.exec("SELECT SUM(cost*num_sold) FROM book").values[0][0].to_f

      result = "You generated $" + sales.to_s + " which cost you $" + cost.to_s + " representing a profit of $" + (sales-cost).round(2).to_s

      get_owner_statement = "SELECT o_id FROM owner WHERE username=$1 AND password=$2"
      response = con.exec_params(get_owner_statement, [@login_session[:username], @login_session[:password]])
      owner_id = response.values[0][0]

      report_satement = "INSERT INTO reports (o_id, day, month, year, report_type, result) VALUES ($1, $2, $3, $4, $5, $6)"
      con.exec_params(report_satement, [owner_id, day, month, year, "SALES_VS_COST", result])

      @session_object_in.db_connection_close(con)
      
      puts result
      Helper.wait
    end
    
    def generate_sales_by_author
      puts "What is the day today?"
      day = gets.chomp
      puts "What is the month today (number)"
      month = gets.chomp
      puts "What is the year today?"
      year = gets.chomp
      con = @session_object_in.db_connection_open
      sales = con.exec("SELECT author_email.first_name, author_email.last_name, 
        SUM(price*num_sold) 
        FROM book
        JOIN author_books 
        ON book.isbn = author_books.isbn
        JOIN author 
        ON author_books.a_id = author.a_id
        JOIN author_email
        ON author.email_address = author_email.email_address
        GROUP BY author_email.first_name, author_email.last_name")
      
      result = ""
      sales.each do |sale|
        result = result + sale["first_name"] + " " + sale["last_name"] + " | $"+ sale["sum"] + "\n"
      end
      get_owner_statement = "SELECT o_id FROM owner WHERE username=$1 AND password=$2"
      response = con.exec_params(get_owner_statement, [@login_session[:username], @login_session[:password]])
      owner_id = response.values[0][0]

      report_satement = "INSERT INTO reports (o_id, day, month, year, report_type, result) VALUES ($1, $2, $3, $4, $5, $6)"
      con.exec_params(report_satement, [owner_id, day, month, year, "SALES_VS_AUTHOR", result])

      @session_object_in.db_connection_close(con)
      
      puts result
      Helper.wait
    end

    def generate_sales_by_genre
      puts "What is the day today?"
      day = gets.chomp
      puts "What is the month today (number)"
      month = gets.chomp
      puts "What is the year today?"
      year = gets.chomp
      con = @session_object_in.db_connection_open
      sales = con.exec("SELECT genre,SUM(price*num_sold) FROM book GROUP BY genre")
      
      result = ""
      sales.each do |sale|
        result = result + sale["genre"] + " | $"+ sale["sum"] + "\n"
      end
      get_owner_statement = "SELECT o_id FROM owner WHERE username=$1 AND password=$2"
      response = con.exec_params(get_owner_statement, [@login_session[:username], @login_session[:password]])
      owner_id = response.values[0][0]

      report_satement = "INSERT INTO reports (o_id, day, month, year, report_type, result) VALUES ($1, $2, $3, $4, $5, $6)"
      con.exec_params(report_satement, [owner_id, day, month, year, "SALES_VS_GENRE", result])

      @session_object_in.db_connection_close(con)
      
      puts result
      Helper.wait
    end

    def get_report_menu
      puts "\nHere are your options: \n"\
      "\n[1] - Exit Program\n"\
      "[2] - Exit to owner menu\n"\
      "[3] - Generate Sales vs. Cost Report\n"\
      "[4] - Generate Sales by Author Report\n"\
      "[5] - Generate Sales by Genre Report\n"\
    end

    #Main Method
    def execute
      while true
        Helper.clear
        get_report_menu
        input = gets.chomp
        
        case input
        when '1'
          Helper.exit_program
        when '2'
          OwnerController.new(@session_object_in, @login_session)
        when '3'
          generate_sales_vs_cost
        when '4'
          generate_sales_by_author
        when '5'
          generate_sales_by_genre
        else
          Helper.invalid_entry_display
        end
      end
    end 
  end
end
  