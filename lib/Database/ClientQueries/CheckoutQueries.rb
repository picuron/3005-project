require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class CheckoutQueries
    def initialize(con)
      @con = con
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
