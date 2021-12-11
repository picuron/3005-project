require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'
require 'pry'

module Client
  class CheckoutQueries
    def initialize(con)
      @con = con
    end

    #upticks num_sold and downticks num_in_stock
    #this also pays the publisher"
    def uptick_num_solds(cart)
      statement = "SELECT isbn FROM cart "\
        "JOIN cart_books ON cart.cart_id = cart_books.cart_id "\
        "WHERE cart.cart_id = $1"
      isbns = @con.exec_params(statement, [cart])
      isbns.each do |isbn|
        # tik up and down sold and stock of given book
        statement2 = "UPDATE book "\
          "SET num_in_stock = num_in_stock - 1, "\
          "num_sold = num_sold + 1 "\
          "WHERE isbn = $1"
        @con.exec_params(statement2, [isbn["isbn"]])
        # pay the publisher of the given book
        publisher_bank_account = @con.exec("SELECT bank_account "\
          "FROM publisher "\
          "JOIN book "\
          "ON publisher.p_id = book.p_id "\
          "WHERE book.isbn = #{isbn["isbn"]}").values[0][0]
        price = @con.exec("SELECT price "\
          "FROM book "\
          "WHERE book.isbn = #{isbn["isbn"]}").values[0][0]
        royalty = @con.exec("SELECT royalty "\
          "FROM book "\
          "WHERE book.isbn = #{isbn["isbn"]}").values[0][0]
          #binding.pry
        @con.exec("UPDATE publisher_bank "\
          "SET account_value = account_value + #{price.to_f*royalty.to_f} "\
          "WHERE bank_account = #{publisher_bank_account.to_i}")
        #check if we have gone under threshold. If so, send an email
        threshold = @con.exec("SELECT threshold_num "\
          "FROM book "\
          "WHERE book.isbn = #{isbn["isbn"]}").values[0][0].to_f
        num_in_stock = @con.exec("SELECT num_in_stock "\
          "FROM book "\
          "WHERE book.isbn = #{isbn["isbn"]}").values[0][0].to_f
        if num_in_stock < threshold
          email = @con.exec("SELECT email_address "\
            "FROM book "\
            "JOIN publisher "\
            "ON book.p_id = publisher.p_id "\
            "WHERE book.isbn = #{isbn["isbn"]}").values[0][0]

          puts "Here we would send an email to #{email} requesting for more copies of #{isbn["isbn"]}. "\
          "We don't currently have any way of keeping track of what month it is, but if we did, we would run "\
          "a query like this..."
          puts "SELECT sum(cart_books.isbn) "
          puts "FROM checkout "
          puts "JOIN cart "
          puts "ON checkout.cart_id = cart.cart_id "
          puts "JOIN cart_books "
          puts "ON cart.cart_id = cart_books.cart_id "
          puts "WHERE month = current_month - 1 "
          puts "AND isbn = isbn_to_order"
          puts "\n instead, I'll just add 10 books to the instock amount"
          Helper.wait

          # add 10 books
          @con.exec("UPDATE book "\
            "SET num_in_stock = num_in_stock + 10 "\
            "WHERE isbn = #{isbn["isbn"]}")
        else
          puts "Plenty more copies of isbn = #{isbn["isbn"]} in stock!"
        end
      end
    end

    def create_address_region_pair_and_return_aid(hash, type)
      @con.exec_params(GenStatements.gen_region_statement, [hash["#{type}_postal_code"], hash["#{type}_city"], hash["#{type}_country"]])
      puts "Region Added"
      @con.exec_params(GenStatements.gen_address_statement, [hash["#{type}_street_number"], hash["#{type}_street_name"], hash["#{type}_postal_code"]])
      puts "Address Added"
      address_id = (@con.exec("SELECT address_id FROM address ORDER BY address_id DESC LIMIT 1")).values[0][0];
      return address_id
    end

    def generate_order(checkout_id)
      @con.exec_params(GenStatements.gen_orders_statment, [checkout_id, "At Warehouse", "At Warehouse", "Unfulfilled"])
      puts "Order Generated"
      return true
    end

    def generate_checkout_success?(date_hash, user, cart, shipping_hash, billing_hash)
      shipping_address = nil
      billing_address = nil
      if shipping_hash == nil && billing_hash == nil
        #user the users parameters
        statement = "SELECT shipping_address_id, billing_address_id FROM customer WHERE c_id = $1"
        elements = @con.exec_params(statement, [user])
        shipping_address = elements.values[0][0]
        billing_address = elements.values[0][1]
      else
        #use the provided parameters
        shipping_address = create_address_region_pair_and_return_aid(shipping_hash, 'shipping')
        puts "Shipping info Added"
        if (shipping_hash["shipping_postal_code"] == billing_hash["billing_postal_code"])
          billing_address = shipping_address
        else
          billing_address = create_address_region_pair_and_return_aid(billing_hash, "billing")
          puts "Billing Info Added"
        end
      end
      @con.exec_params(GenStatements.gen_checkout_statement, [billing_address, shipping_address, user, cart, date_hash["day"], date_hash["month"], date_hash["year"]])
      check_id = (@con.exec("SELECT check_id FROM checkout ORDER BY check_id DESC LIMIT 1")).values[0][0]
      generate_order(check_id)
    end
  end
end
