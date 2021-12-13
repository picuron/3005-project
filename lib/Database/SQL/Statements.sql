-- {X, Y, Z ... etc} represents string interpolations done by programmer with no risk on injection
-- {$1, $2, $3 .. etc } represents prepared statement variables



--------------------------------------- FROM Populate.rb ---------------------------------------

-- Generates a new cart
INSERT INTO cart VALUES(default)



--------------------------------------- FROM InitDB.rb ---------------------------------------

-- All the statements needed to drop the tables, if they exist, and cascade their effects
DROP TABLE IF EXISTS cart CASCADE
DROP TABLE IF EXISTS author_email CASCADE
DROP TABLE IF EXISTS owner_email CASCADE
DROP TABLE IF EXISTS publisher_email CASCADE
DROP TABLE IF EXISTS customer_email CASCADE
DROP TABLE IF EXISTS publisher_bank CASCADE
DROP TABLE IF EXISTS region CASCADE
DROP TABLE IF EXISTS address CASCADE
DROP TABLE IF EXISTS author CASCADE
DROP TABLE IF EXISTS publisher CASCADE
DROP TABLE IF EXISTS book CASCADE
DROP TABLE IF EXISTS owner CASCADE
DROP TABLE IF EXISTS customer CASCADE
DROP TABLE IF EXISTS reports CASCADE
DROP TABLE IF EXISTS checkout CASCADE
DROP TABLE IF EXISTS orders CASCADE
DROP TABLE IF EXISTS cart_books CASCADE
DROP TABLE IF EXISTS author_books CASCADE
DROP TABLE IF EXISTS author_phone_number CASCADE
DROP TABLE IF EXISTS owner_phone_number CASCADE
DROP TABLE IF EXISTS customer_phone_number CASCADE
DROP TABLE IF EXISTS publisher_phone_number CASCADE


-- Create extension needed for Levenshtein function
CREATE EXTENSION fuzzystrmatch



--------------------------------------- FROM GenStatments.rb ---------------------------------------

-- All of the below statements insert a record into a table with the given properties provided in prepared statements

INSERT INTO author_email           (email_address, first_name, last_name)                                                             VALUES ($1, $2, $3)      
INSERT INTO owner_email            (email_address, first_name, last_name)                                                             VALUES ($1, $2, $3)  
INSERT INTO publisher_email        (email_address, name)                                                                              VALUES ($1, $2)    
INSERT INTO customer_email         (email_address, first_name, last_name)                                                             VALUES ($1, $2, $3)    
INSERT INTO publisher_bank         (bank_account, account_value)                                                                      VALUES ($1, $2)            
INSERT INTO region                 (postal_code, city, country)                                                                       VALUES ($1, $2, $3)          
INSERT INTO address                (street_number, street_name, postal_code)                                                          VALUES ($1, $2, $3)            
INSERT INTO author                 (email_address)                                                                                    VALUES ($1)         
INSERT INTO publisher              (address_id, email_address, bank_account)                                                          VALUES ($1, $2, $3)              
INSERT INTO book                   (isbn, p_id, title, genre, royalty, num_pages, price, cost, num_in_stock, threshold_num, num_sold) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)            
INSERT INTO owner                  (email_address, username, password)                                                                VALUES ($1, $2, $3)          
INSERT INTO customer               (shipping_address_id, billing_address_id, email_address, username, password)                       VALUES ($1, $2, $3, $4, $5)            
INSERT INTO reports                (o_id, day, month, year, report_type, result)                                                      VALUES ($1, $2, $3, $4, $5, $6)          
INSERT INTO checkout               (billing_address_id, shipping_address_id, c_id, cart_id, day, month, year)                         VALUES ($1, $2, $3, $4, $5, $6, $7)            
INSERT INTO orders                 (check_id, cl_city, cl_country, status)                                                            VALUES ($1, $2, $3, $4)       
INSERT INTO cart_books             (cart_id, isbn)                                                                                    VALUES ($1, $2)                
INSERT INTO author_books           (isbn, a_id)                                                                                       VALUES ($1, $2)        
INSERT INTO author_phone_number    (a_id, phone_number)                                                                               VALUES ($1, $2)       
INSERT INTO owner_phone_number     (o_id, phone_number)                                                                               VALUES ($1, $2)       
INSERT INTO customer_phone_number  (c_id, phone_number)                                                                               VALUES ($1, $2)        
INSERT INTO publisher_phone_number (p_id, phone_number)                                                                               VALUES ($1, $2)



--------------------------------------- FROM CheckoutQueries.rb ---------------------------------------

-- change the num_instock and num_sold tickers given isbn
UPDATE book
          SET num_in_stock = num_in_stock - 1,
          num_sold = num_sold + 1
          WHERE isbn = $1

-- add money into publisher bank given price, royalty, and bank_account
UPDATE publisher_bank
          SET account_value = account_value + (X*Y)
          WHERE bank_account = Z

-- adjust num in stock + X, given isbn, where X is last months num_sold.
UPDATE book 
          SET num_in_stock = num_in_stock + X 
          WHERE isbn = Y


--------------------------------------- FROM RemoveBooksQueries.rb ---------------------------------------

-- removes a book from a cart based on cart id and isbn
DELETE FROM cart_books WHERE isbn =$1 AND cart_id=$2