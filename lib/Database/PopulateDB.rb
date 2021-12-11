require 'pg'
require 'io/console'
require 'faker'
require_relative './GenStatements.rb'

module Database
  class PopulateDB
    def initalize(con)
      @con = con
      execute
    end

    private
    def generate_random_postal_code
      (1..3).map{
        "#{('A'..'Z').to_a[rand(26)]}#{(0..9).to_a[rand(9)]}"
      }.join
    end

    def prep_result(select_, from, where, equals)
      query = "SELECT #{select_} FROM #{from} WHERE #{where}=$1"
      query_result = @con.exec_params(query, [equals])
    end

    def is_valid_insert(table_name, attribute_name, value_name)

      query = "SELECT COUNT(*) FROM #{table_name} WHERE #{attribute_name}=$1"
      query_result = @con.exec_params(query, [value_name])
      
      if(query_result.values[0][0].to_i == 0)
        return true
      end
      false
    end

    def create_address_region_pair_and_return_aid
      postal_code = generate_random_postal_code
      @con.exec_params(GenStatements.gen_region_statement, [postal_code, Faker::Address.city, Faker::Address.country])
      @con.exec_params(GenStatements.gen_address_statement, [Faker::Address.building_number, Faker::Address.street_name, postal_code])
      address_id = (@con.exec("SELECT address_id FROM address ORDER BY address_id DESC LIMIT 1")).values[0][0];
      return address_id
    end

    def create_author_author_phone_author_email_triple_and_return_aid
      puts "New author, author_phone_number and author_email created."

      email = Faker::Internet.email
      phone = Faker::Base.numerify('(###) ### ####')
      if is_valid_insert("author_email", "email_address", email)
        @con.exec_params(GenStatements.gen_author_email_statement, [email, Faker::Name.first_name, Faker::Name.last_name])
        @con.exec_params(GenStatements.gen_author_statement, [email]) 
        author_id = prep_result('a_id', 'author', 'email_address', email).values[0][0].to_i
        @con.exec_params(GenStatements.gen_author_phone_number, [author_id, phone])
        return author_id
      else
        puts "Edge case resolved: Duplicate randomly generated author email detected."
      end
      return NULL # not sure what to do in this case
    end

    def create_publisher_tables
      email = Faker::Internet.email
      phone = Faker::Base.numerify('(###) ### ####')
      bank_number = Faker::Bank.account_number(digits: 7)
      publisher_name = Faker::Company.name
      if is_valid_insert("publisher_email", "email_address", email) && is_valid_insert("publisher_email", "name", publisher_name) && is_valid_insert("publisher_bank", "bank_account", bank_number)
        @con.exec_params(GenStatements.gen_publisher_email_statement, [email, publisher_name])
        @con.exec_params(GenStatements.gen_publisher_bank_statement, [bank_number, Faker::Number.between({from: 10000, to: 1000000})])
        @con.exec_params(GenStatements.gen_publisher_statement, [create_address_region_pair_and_return_aid, email, bank_number])

        publisher_id = (@con.exec("SELECT p_id FROM publisher ORDER BY p_id DESC LIMIT 1")).values[0][0];
        @con.exec_params(GenStatements.gen_publisher_phone_number, [publisher_id, phone])
      else
        puts "Edge case resolved: Duplicate randomly generated publisher unique value detected."
      end
    end

    def create_customer_tables
      email = Faker::Internet.email
      phone = Faker::Base.numerify('(###) ### ####')
      username = Faker::Internet.username
      if is_valid_insert("customer_email", "email_address", email) && is_valid_insert("customer", "username", username)
        @con.exec_params(GenStatements.gen_customer_email_statement, [email, Faker::Name.first_name, Faker::Name.last_name])
        
        #Address 1
        shipping_addess = create_address_region_pair_and_return_aid
    
        #Address 2 - If 1, different billing address than shipping, if 0, billing and shipping are the same.
        if rand(0..1) == 1
          billing_address = create_address_region_pair_and_return_aid
          @con.exec_params(GenStatements.gen_customer_statement, [shipping_addess, billing_address, email, username, Faker::Internet.password])
        else
          @con.exec_params(GenStatements.gen_customer_statement, [shipping_addess, shipping_addess, email, username, Faker::Internet.password])
        end

        customer_id = (@con.exec("SELECT c_id FROM customer ORDER BY c_id DESC LIMIT 1")).values[0][0];
        @con.exec_params(GenStatements.gen_customer_phone_number, [customer_id, phone])
      end
    end

    def get_random_genre
      ['Comedy', 'Romance', 'Horror', 'Children', 'Sci-Fi', 'Biography'].sample
    end

    def get_random_publisher
      publisher_ids = []
      publishers = @con.exec("SELECT p_id FROM publisher");

      publishers.each do |publisher|
        publisher_ids << publisher['p_id']
      end

      publisher_ids.sample
    end

    def get_random_author
      author_ids = []
      authors = @con.exec("SELECT a_id FROM author");

      authors.each do |author|
        author_ids << author['a_id']
      end

      author_ids.sample
    end

    def get_books
      isbns = []
      books = @con.exec("SELECT isbn FROM book");

      books.each do |book|
        isbns << book['isbn']
      end

      isbns
    end

    def get_carts
      cart_ids = []
      carts = @con.exec("SELECT cart_id FROM cart");

      carts.each do |cart|
        cart_ids << cart['cart_id']
      end

      cart_ids
    end

    def get_random_customer
      customer_ids = []
      customers = @con.exec("SELECT c_id FROM customer");

      customers.each do |customer|
        customer_ids << customer['c_id']
      end

      customer_ids.sample
    end

    def create_book_table
      isbn = Faker::Number.number(digits: 9)
      title = Faker::Book.title
      genre = get_random_genre
      royalty = ((rand(1..10).to_f) /100)
      num_pages = rand(50..500)
      price = (rand() * 100).round(2)
      cost = price * ((rand(50..90).to_f)/100)
      num_in_stock = rand(10..100)
      num_sold = rand(0..100)

      publisher_id = get_random_publisher

      if is_valid_insert("book", "isbn", isbn) && is_valid_insert("book", "title", title)
        @con.exec_params(GenStatements.gen_book_statement, [isbn, publisher_id, title, genre, royalty, num_pages, price, cost, num_in_stock, 5, num_sold])
      else
        puts "Edge case resolved: Duplicate randomly generated book value detected."
      end

      num_authors = rand(1..3)

      num_authors.times do 
        if rand(0..2) == 1 # 1/3 chance that an existing author wrote this book as well
          author_id = get_random_author
        else
          author_id = create_author_author_phone_author_email_triple_and_return_aid
        end

        # Theres a chance two of the same authors could be picked. This should trap this case.
        begin
          @con.exec_params(GenStatements.gen_author_books, [isbn, author_id])
        rescue => exception
        end
        
      end
    end

    def create_carts
      @con.exec("INSERT INTO cart VALUES(default)")
      cart_id = (@con.exec("SELECT cart_id FROM cart ORDER BY cart_id DESC LIMIT 1")).values[0][0]

      all_books = get_books

      num_books_in_cart = rand(1..5)

      books_in_cart = all_books.sample(num_books_in_cart)

      books_in_cart.each do |book|
        @con.exec_params(GenStatements.gen_cart_books_statement, [cart_id, book])
      end
    end

    def create_orders
      #Assume that half the carts, 10 will result in a checkout.
      checkout_carts = get_carts.sample(10)

      # Create Cart
      checkout_carts.each do |cart_id|
        c_id = get_random_customer
        day = rand(1..28)
        month = rand(1..12)
        year = 2021
        #Address 1
        shipping_addess = create_address_region_pair_and_return_aid
    
        #Address 2 - If 1, different billing address than shipping, if 0, billing and shipping are the same.
        if rand(0..1) == 1
          billing_address = create_address_region_pair_and_return_aid
          @con.exec_params(GenStatements.gen_checkout_statement, [billing_address, shipping_addess, c_id, cart_id, day, month, year])
        else
          @con.exec_params(GenStatements.gen_checkout_statement, [shipping_addess, shipping_addess, c_id, cart_id, day, month, year])
        end

        # Create order
        #(check_id, cl_city, cl_country, status)
        checkout_id = (@con.exec("SELECT check_id FROM checkout ORDER BY check_id DESC LIMIT 1")).values[0][0]

        #1/2 chance of not being fulfilled yet
        if rand(0..1) == 1
          @con.exec_params(GenStatements.gen_orders_statment, [checkout_id, "At Warehouse", "At Warehouse", "UNFULFILLED"])
        else
          @con.exec_params(GenStatements.gen_orders_statment, [checkout_id, Faker::Address.city, Faker::Address.country, "SHIPPED"])
        end

        puts "New cart and checkout created."
      end
    end

    def execute
      puts "Beginning data population:"

      #generate the default owner
      @con.exec_params(GenStatements.gen_owner_email_statement, ['ahmedelroby@gmail.com', 'Ahmed', 'ElRoby'])
      @con.exec_params(GenStatements.gen_owner_statement, ['ahmedelroby@gmail.com', 'ElRoby', 'COMP3005'])
      @con.exec_params(GenStatements.gen_owner_phone_number, [1, '(613) 520-2600'])

      20.times{
        puts "New publisher, publisher_phone_number and publisher_email and publisher_bank created."
        create_publisher_tables
      }

      20.times{
        puts "New customer, customer_phone_number and customer_email created."
        create_customer_tables
      }

      20.times{
        puts "New book created."
        create_book_table
      }

      20.times{
        puts "New cart created."
        create_carts
      }

      create_orders

      puts "Data population is complete."
    end
  end
end