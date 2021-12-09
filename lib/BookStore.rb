#!/usr/bin/ruby
require './BookStoreController'

# This class should be the starting point. The program is launched from in here, and then user flow begins from this class.
# DO NOT CHANGE THIS CLASS. User flow begins in BookStoreController. This classes only purpose is to initalize the BookStoreController
class Initalizer

  BookStoreController.new

end

