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
      #query for what we need, generate the numbers, save as a report
      puts "Generated sales vs cost"
      Helper.wait
    end
    
    def generate_sales_by_author
      #query for what we need, generate the numbers, save as a report
      puts "Generated sales by author"
      Helper.wait
    end

    def generate_sales_by_genre
      #query for what we need, generate the numbers, save as a report
      puts "Generated sales by genre"
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
  