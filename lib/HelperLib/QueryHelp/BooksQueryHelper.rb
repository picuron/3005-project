require_relative '../Helper.rb'

module Helper
  class BooksQueryHelper
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      #execute
    end

    public
    # Helper Functions
    def book_options_on_display_message(key, value)
      Helper.clear
      puts "Here are all our books, after having performed a query for them\n"
      if(key != "" && value != "")
        puts "given the provided key #{key} and value #{value} \n"
      end
      puts "\n-----Books-----\n"\
      "ISBN: 1234         Book: example1 \n"\
      "ISBN: 4321         Book: example2 \n"\
      "ISBN: 1324         Book: example3 \n"
      puts "Type in an ISBN to learn more about a book, or \'enter\' to exit"
      return ["1234", "4321", "1324"]
    end

    def query_for_books_by_param(key, value)
      while true
        book_options_array = book_options_on_display_message(key, value)
        input = gets.chomp
        if input == ''
          break
        elsif book_options_array.include? input
          Helper.clear
          puts "\nDisplaying all info about book with ISBN = #{input}\n"\
          "Would you like to add this book to your Cart? \n"\
          "[0] - No, Return to Book List\n"\
          "[1] - Yes, Add to Cart\n"
          input2 = gets.chomp
          case input2
          when '0'
            next
          when '1'
            Helper.clear 
            puts "Book with ISBN#: #{input} Has Been Added to Cart"
          end
        else 
          Helper.invalid_entry_display
        end 
        Helper.wait
      end
    end

    #Main Method
    # def execute
    #   puts "In BooksQueryHelp Execute"
    #   Helper.wait
    # end 
  end
end