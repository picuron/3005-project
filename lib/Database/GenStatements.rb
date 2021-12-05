class GenStatements
  class << GenStatements

    def gen_author_email_statement
      "INSERT INTO author_email           (email_address, first_name, last_name)                VALUES ($1, $2, $3)"
    end
    def gen_owner_email_statement        
      "INSERT INTO owner_email            (email_address, first_name, last_name)                VALUES ($1, $2, $3)"
    end
    def gen_publisher_email_statement    
      "INSERT INTO publisher_email        (email_address, name)                                 VALUES ($1, $2)"
    end
    def gen_customer_email_statement     
      "INSERT INTO customer_email         (email_address, first_name, last_name)                VALUES ($1, $2, $3)"
    end
    def gen_publisher_bank_statement     
      "INSERT INTO publisher_bank         (bank_account, account_value)                         VALUES ($1, $2)"
    end
    def gen_region_statement             
      "INSERT INTO region                 (postal_code, city, country)                          VALUES ($1, $2, $3)"
    end
    def gen_address_statement            
      "INSERT INTO address                (street_number, street_name, postal_code)             VALUES ($1, $2, $3)"
    end
    def gen_author_statement             
      "INSERT INTO author                 (email_address)                                       VALUES ($1)"
    end
    def gen_publisher_statement          
      "INSERT INTO publisher              (address_id, email_address, bank_account)             VALUES ($1, $2, $3)"
    end
    def gen_book_statement               
      "INSERT INTO book                   (isbn, p_id, title, genre, royalty, num_pages, price, cost, num_in_stock, threshold_num, num_sold) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)"
    end
    def gen_owner_statement              
      "INSERT INTO owner                  (email_address, username, password)                   VALUES ($1, $2, $3)"
    end
    def gen_customer_statement           
      "INSERT INTO customer               (shipping_address_id, billing_address_id, email_address, username, password) VALUES ($1, $2, $3, $4, $5)"
    end
    def gen_reports_statment             
      "INSERT INTO reports                (o_id, day, month, year, report_type, result)         VALUES ($1, $2, $3, $4, $5, $6)"
    end
    def gen_checkout_statement           
      "INSERT INTO checkout               (billing_address_id, shipping_addres_id, c_id, cart_id, day, month, year) VALUES ($1, $2, $3, $4, $5, $6, $7)"
    end
    def gen_orders_statment              
      "INSERT INTO orders                 (o_id, check_id, cl_city, cl_country, status)         VALUES ($1, $2, $3, $4, $5)"
    end
    def gen_cart_books_statement         
      "INSERT INTO cart_books             (cart_id, isbn)                                       VALUES ($1, $2)"
    end
    def gen_book_author                  
      "INSERT INTO book_author            (isbn, a_id)                                          VALUES ($1, $2)"
    end
    def gen_author_phone_number          
      "INSERT INTO author_phone_number    (a_id, phone_number)                                  VALUES ($1, $2)"
    end
    def gen_owner_phone_number          
      "INSERT INTO owner_phone_number     (o_id, phone_number)                                  VALUES ($1, $2)"
    end
    def gen_customer_phone_number          
      "INSERT INTO customer_phone_number  (c_id, phone_number)                                  VALUES ($1, $2)"
    end
    def gen_publisher_phone_number          
      "INSERT INTO publisher_phone_number (p_id, phone_number)                                  VALUES ($1, $2)"
    end
  end 
end
