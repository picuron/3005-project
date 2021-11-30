require_relative '../HelperLib/Helper.rb'
require_relative '../HelperLib/QueryHelp/BooksQueryHelper.rb'

module Client
  class BrowseBooks
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      execute
    end

    private
    #Main Method
    def execute
      puts "In BrowsseBooks Execute"
      Helper.wait
      Helper::BooksQueryHelper.new(@db).query_for_books_by_param("", "")
      Helper.wait
    end 
  end
end