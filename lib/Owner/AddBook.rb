require_relative '../HelperLib/Helper.rb'
require_relative '../Database/OwnerQueries/AddBookQueries.rb'
require 'pry'

module Owner
  class AddBook
    def initialize(session_object_in, login_session)
      @session_object_in = session_object_in
      @login_session = login_session
      @publisher_object_array = []
      @publisher_ids = []
      @author_ids = []
      Helper.clear
      execute
    end

    private
    def get_publishers
      puts "One moment, fetching publishers."
      con = @session_object_in.db_connection_open
      publishers = AddBookQueries.new(con).get_publishers
      @session_object_in.db_connection_close(con)

      # publisher_object_array = []

      publishers.each do |publisher|
        @publisher_object_array << {id: publisher["p_id"], name: publisher["name"]}
        @publisher_ids << publisher["p_id"]
      end

      @publisher_object_array
    end

    def print_publishers(publishers)
      publishers.each {|publisher|
        puts "ID: " + publisher[:id] + " | Name: " + publisher[:name]
      }
    end

    def was_publisher_present?
      puts "\nWas your publisher listed? (Y/N)"
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

    def get_phone_numbers_menu
      puts "\nHere are your options: \n"\
      "\n[1] - Done Entering Phone Numbers\n"\
      "[2] - Add another phone number\n"\
    end

    def get_phone_numbers
      puts "Please enter a phone number: "
      phone_number_1 = gets.chomp

      phone_numbers = [phone_number_1]      

      while true
        get_phone_numbers_menu
        input = gets.chomp
        
        case input
        when '1'
          return phone_numbers
        when '2'
          puts "Enter another phone number:"
          phone_number_input = gets.chomp
          phone_numbers.push(phone_number_input)
        else
          Helper.invalid_entry_display
        end
      end
    end

    def valid_publisher_name(name)
      con = @session_object_in.db_connection_open
      name_statement = "SELECT COUNT(*) FROM publisher_email WHERE name=$1"
      query_result = con.exec_params(name_statement, [name])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def valid_publisher_email(email)
      con = @session_object_in.db_connection_open
      email_statment = "SELECT COUNT(*) FROM publisher_email WHERE email_address=$1"
      query_result = con.exec_params(email_statment, [email])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def valid_publisher_bank(bank_account)
      con = @session_object_in.db_connection_open
      bank_account_statment = "SELECT COUNT(*) FROM publisher_bank WHERE bank_account=$1"
      query_result = con.exec_params(bank_account_statment, [bank_account])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def valid_publisher_postal(postal_code)
      con = @session_object_in.db_connection_open
      postal_code_statment = "SELECT COUNT(*) FROM region WHERE postal_code=$1"
      query_result = con.exec_params(postal_code_statment, [postal_code])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def valid_author_email(email)
      con = @session_object_in.db_connection_open
      email_statment = "SELECT COUNT(*) FROM author_email WHERE email_address=$1"
      query_result = con.exec_params(email_statment, [email])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def create_publisher
      while true
        puts "Enter the publisher name:"
        name = gets.chomp
        break if valid_publisher_name(name)

        puts "That name was taken. Try again.\n\n"
      end
      while true
        puts "Enter the publishers email:"
        email = gets.chomp
        break if valid_publisher_email(email)

        puts "That email was taken. Try again.\n\n"
      end
      phone_numbers = get_phone_numbers
      puts "Enter the publishers street number:"
      street_number = gets.chomp
      puts "Enter the publishers street name:"
      street_name = gets.chomp
      puts "Enter the publishers city:"
      city = gets.chomp
      puts "Enter the publishers country:"
      country = gets.chomp
      while true
        puts "Enter the publishers postal code:"
        postal_code = gets.chomp
        break if valid_publisher_postal(postal_code)

        puts "That postal code was taken. Try again.\n\n"
      end
      while true
        puts "Enter the publishers bank account number:"
        bank_account_number = gets.chomp
        break if valid_publisher_bank(bank_account_number)

        puts "That bank account was taken. Try again.\n\n"
      end
      account_value = 0

      # Call create publisher query here, return back the ID of it
      con = @session_object_in.db_connection_open
      con.exec_params(GenStatements.gen_region_statement, [postal_code, city, country])
      con.exec_params(GenStatements.gen_address_statement, [street_number, street_name, postal_code])
      address_id = (con.exec("SELECT address_id FROM address ORDER BY address_id DESC LIMIT 1")).values[0][0];

      con.exec_params(GenStatements.gen_publisher_email_statement, [email, name])
      con.exec_params(GenStatements.gen_publisher_bank_statement, [bank_account_number, account_value])
      con.exec_params(GenStatements.gen_publisher_statement, [address_id, email, bank_account_number])

      publisher_id = (con.exec("SELECT p_id FROM publisher ORDER BY p_id DESC LIMIT 1")).values[0][0];
      
      phone_numbers.each do |phone_number|
        con.exec_params(GenStatements.gen_publisher_phone_number, [publisher_id, phone_number])
      end
      @session_object_in.db_connection_close(con)

      puts "\nSuccessfully created publisher.\n"

      publisher_id
    end

    def check_if_publisher_valid(publisher_id)
      return true if @publisher_ids.include?(publisher_id)
      false
    end

    def check_if_author_valid(author_id)
      return true if @author_ids.include?(author_id)
      false
    end

    def invalid_publisher_menu
      puts "\nThat publisher ID was invalid. Here are your options: \n"\
      "\n[1] - Try another publisher\n"\
      "[2] - Create new publisher\n"\
    end

    def invalid_author_menu
      puts "\nThat author ID was invalid. Here are your options: \n"\
      "\n[1] - Try another author\n"\
      "[2] - Create new author\n"\
    end

    def valid_book_isbn(isbn)
      con = @session_object_in.db_connection_open
      book_statment = "SELECT COUNT(*) FROM book WHERE isbn=$1"
      query_result = con.exec_params(book_statment, [isbn])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def valid_book_title(title)
      con = @session_object_in.db_connection_open
      book_statment = "SELECT COUNT(*) FROM book WHERE title=$1"
      query_result = con.exec_params(book_statment, [title])

      @session_object_in.db_connection_close(con)

      if(query_result.values[0][0].to_i > 0)
        return false
      end
      true
    end

    def display_authors
      con = @session_object_in.db_connection_open
      authors = con.exec("SELECT a_id, author_email.first_name, author_email.last_name FROM author JOIN author_email ON author.email_address = author_email.email_address")
      @session_object_in.db_connection_close(con)
      
      authors.each do |author|
        puts "ID: " + author["a_id"] + " | Name: " + author["first_name"] + " " + author["last_name"]
        @author_ids << author["a_id"]
      end 
    end

    def display_author_menu
      puts "\nWas the author you would like to add listed? \n"\
      "\n[1] - Yes\n"\
      "[2] - No, I will create a new one\n"\
    end

    def add_another_author_menu
      puts "\nDo you want to add another author to this book? \n"\
      "\n[1] - Yes\n"\
      "[2] - No\n"\
    end

    def create_author(isbn)
      while true
        puts "Enter the authors email:"
        email = gets.chomp
        break if valid_author_email(email)

        puts "That email was taken. Try again.\n\n"
      end
      phone_numbers = get_phone_numbers
      puts "Enter the authors first name:"
      first_name = gets.chomp
      puts "Enter the authors last name:"
      last_name = gets.chomp

      con = @session_object_in.db_connection_open
      con.exec_params(GenStatements.gen_author_email_statement, [email, first_name, last_name])
      con.exec_params(GenStatements.gen_author_statement, [email]) 
      author_id = (con.exec("SELECT a_id FROM author ORDER BY a_id DESC LIMIT 1")).values[0][0];
      phone_numbers.each do |phone_number|
        con.exec_params(GenStatements.gen_author_phone_number, [author_id, phone_number])
      end
      con.exec_params(GenStatements.gen_author_books, [isbn, author_id])
      @session_object_in.db_connection_close(con)
    end

    def add_author(isbn)
    
      while true
        display_authors
        display_author_menu

        input = gets.chomp

        case input
        when '1'
          puts "What was the authors' ID?"
          author_id = gets.chomp
          if check_if_author_valid(author_id)
            con = @session_object_in.db_connection_open
            con.exec_params(GenStatements.gen_author_books, [isbn, author_id])
            @session_object_in.db_connection_close(con)
            break
          else
            Helper.clear
            invalid_author_menu
            input = gets.chomp
          
            case input
            when '1'
              next
            when '2'
              author_id = create_author(isbn)
              break
            else
              Helper.invalid_entry_display
            end
          end
        when '2'
          author_id = create_author(isbn)
          break
        else
          Helper.invalid_entry_display
        end
      end

    end
    #Main Method
    def execute
      Helper.clear
      publishers = get_publishers
      print_publishers(publishers)
      
      publisher_present = was_publisher_present?

      if publisher_present
        while true
          puts "What was the publisher's ID?"
          publisher_id = gets.chomp
          break if check_if_publisher_valid(publisher_id)

          invalid_publisher_menu
          input = gets.chomp
        
          case input
          when '1'
            next
          when '2'
            publisher_id = create_publisher 
            break
          else
            Helper.invalid_entry_display
          end
        end
      else
        publisher_id = create_publisher  
      end

      while true
        puts "\nWhat is the books ISBN"
        isbn = gets.chomp
        break if valid_book_isbn(isbn)

        puts "That ISBN was taken. Try again.\n\n"
      end

      while true
        puts "What is the books title"
        title = gets.chomp
        break if valid_book_title(title)

        puts "That title was taken. Try again.\n\n"
      end
      puts "What is the books genre?"
      genre = gets.chomp
      puts "What is the books royalty. Write a percent as a decimal. IE. 5% = 0.05"
      royalty = gets.chomp
      puts "How many pages are there?"
      num_pages = gets.chomp
      puts "What is the books price?"
      price = gets.chomp
      puts "What is the books cost?"
      cost = gets.chomp
      puts "Enter current stock of the book"
      stock = gets.chomp
      threshold_num = 5
      num_sold = 0
      
      con = @session_object_in.db_connection_open
      con.exec_params(GenStatements.gen_book_statement, [isbn, publisher_id, title, genre, royalty, num_pages, price, cost, stock, threshold_num, num_sold])
      @session_object_in.db_connection_close(con)
      puts "\nThank you! #{title} is being added."
      Helper.clear

      puts "Please add an author: "

      add_author(isbn)

      while true
        add_another_author_menu
        input = gets.chomp
      
        case input
        when '1'
          Helper.clear
          add_author(isbn)
        when '2'
          break
        else
          Helper.invalid_entry_display
        end
      end
      puts "Book successfully added!"
      Helper.wait
    end 
  end
end
  