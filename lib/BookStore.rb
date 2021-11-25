#!/usr/bin/ruby
require './BookStoreController'

# This class should be the starting point. The program is launched from in here, and then user flow begins from this class.
class Initalizer

  BookStoreController.new.initalize
  
end

