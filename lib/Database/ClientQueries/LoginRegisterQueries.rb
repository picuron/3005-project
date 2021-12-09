require_relative '../GenStatements.rb'

module Client
  class LoginRegisterQueries
    def initialize(con)
      @con = con
    end

    def fetch_user(username, password)
      statement = "SELECT * FROM customer "\
      "NATURAL JOIN customer_email "\
      "NATURAL JOIN customer_phone_number "\
      "JOIN address AS s_ad ON customer.shipping_address_id = s_ad.address_id "\
      "JOIN address AS b_ad ON customer.billing_address_id = b_ad.address_id "\
      "JOIN region AS r_s ON r_s.postal_code = s_ad.postal_code "\
      "JOIN region AS r_b ON r_b.postal_code = b_ad.postal_code "\
      "WHERE username=$1 AND password=$2"
      @con.exec_params(statement, [username, password])
    end

    def is_valid_insert(table_name, attribute_name, value_name)
      query = "SELECT COUNT(*) FROM #{table_name} WHERE #{attribute_name}=$1"
      query_result = @con.exec_params(query, [value_name])
      if(query_result.values[0][0].to_i == 0)
        return true
      end
      false
    end

    def create_address_region_pair_and_return_aid(hash, type)
      @con.exec_params(GenStatements.gen_region_statement, [hash["#{type}_postal_code"], hash["#{type}_city"], hash["#{type}_country"]])
      puts "Region Added"
      @con.exec_params(GenStatements.gen_address_statement, [hash["#{type}_street_number"], hash["#{type}_street_name"], hash["#{type}_postal_code"]])
      puts "Address Added"
      address_id = (@con.exec("SELECT address_id FROM address ORDER BY address_id DESC LIMIT 1")).values[0][0];
      return address_id
    end

    def create_customer_tables(hash)
      if is_valid_insert("customer_email", "email_address", hash["email_address"]) && is_valid_insert("customer", "username", hash["username"])
        @con.exec_params(GenStatements.gen_customer_email_statement, [hash["email_address"], hash["first_name"], hash["last_name"]])
        puts "Customer Email Added"
        shipping_address = create_address_region_pair_and_return_aid(hash, "shipping")
        puts "Shipping Info Added"
        billing_address = nil
        if (hash["shipping_postal_code"] == hash["billing_postal_code"])
          billing_address = shipping_address
        else
          billing_address = create_address_region_pair_and_return_aid(hash, "billing")
          puts "Billing Info Added"
        end
        @con.exec_params(GenStatements.gen_customer_statement, [shipping_address, billing_address, hash["email_address"], hash["username"], hash["password"]])
        puts "Customer Added"
        customer_id = (@con.exec("SELECT c_id FROM customer ORDER BY c_id DESC LIMIT 1")).values[0][0];
        hash["phone_numbers"].each do |phone_number|
          @con.exec_params(GenStatements.gen_customer_phone_number, [customer_id, phone_number])
          puts "Customer Phone Number Added"
        end
        return customer_id
      else return nil
      end
    end

    def generate_new_user(user_info_hash)
      # user_info_hash = {
      # "username" => data
      # "password" => data
      # "email_address" => data
      # "first_name" => data
      # "last_name" => data
      # 'phone_numbers' => [data]
      # 'billing_street_number' => data
      # 'billing_street_name' => data
      # 'billing_postal_code' => data
      # 'billing_city' => data
      # 'billing_country' => data
      # 'shipping_street_number' => data
      # 'shipping_street_name' => data
      # 'shipping_postal_code' => data
      # 'shipping_city' => data
      # 'shipping_country' => data
      # }
      return create_customer_tables(user_info_hash)
    end
  end
end