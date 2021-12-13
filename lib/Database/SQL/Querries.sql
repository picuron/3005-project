-- {X, Y, Z, ... etc} will be used when string interpolation was used in the file
-- {$1, $2, $3, ... etc} will be used when prepared statements where used. 

-- Note: String interpolation was only used when the injected string was determined by the writer of the program, not by the user
-- As such, there is no threat for SQL injections to cause a problem.


--------------------------------------- FROM Populate.rb ---------------------------------------

-- This query was written to allow us to return any attributes, from any table, on any condition, depending on circumstance.
SELECT X FROM Y WHERE Z=$1

-- This query was used as a is_valid_insert" check. If we get back the number 0, the value is unique and we can use it
SELECT COUNT(*) FROM X WHERE Y=$1

-- This was used after adding a publisher, so we can fetch the most recent publisher (the one just added) so we could use its
-- p_id to populate the publisher_phone_number table.
SELECT p_id FROM publisher ORDER BY p_id DESC LIMIT 1

-- Same as above, but for customer
SELECT c_id FROM customer ORDER BY c_id DESC LIMIT 1

-- Fetches list of publisher id's. 
SELECT p_id FROM publisher

-- Fetches list of author id's
SELECT a_id FROM author

-- Fetches list of isbn's
SELECT isbn FROM book

-- Fetches list of cart_id's
SELECT cart_id FROM cart

-- Fetches list of cutomer id's
SELECT c_id FROM customer

-- Fetches the most recently added cart's id
SELECT cart_id FROM cart ORDER BY cart_id DESC LIMIT 1

-- Fetches most recently added checkout
SELECT check_id FROM checkout ORDER BY check_id DESC LIMIT 1



--------------------------------------- FROM BrowseBooksQueries.rb ---------------------------------------

-- allows user to query for book by key and values
SELECT isbn, title FROM book WHERE $1=$2

-- fetch all data about book given isbn
SELECT 
      title,
      isbn,
      genre,
      num_pages,
      price,
      num_in_stock,
      num_sold,
      name
      FROM book
      NATURAL JOIN publisher
      NATURAL JOIN publisher_email
      WHERE isbn =$1

-- fetch all first_name last_name tuples of author given book isbn
SELECT first_name, last_name
      FROM author_books
      NATURAL JOIN author
      NATURAL JOIN author_email
      WHERE isbn=$1
      


--------------------------------------- FROM CartQueries.rb ---------------------------------------

-- fetch (isbn, title, price) triples, given a cart_id
SELECT isbn, title, price
        FROM cart_books
        NATURAL JOIN book
        WHERE cart_id =$1



--------------------------------------- FROM CheckoutQueries.rb ---------------------------------------

-- get all isbn's from a given cart
SELECT isbn FROM cart
        JOIN cart_books ON cart.cart_id = cart_books.cart_id
        WHERE cart.cart_id = $1

-- get the publishers bank account given isbn
SELECT bank_account
          FROM publisher
          JOIN book
          ON publisher.p_id = book.p_id
          WHERE book.isbn = X

-- get book price given isbn
SELECT price FROM book WHERE book.isbn = X

-- get royalty from book given isbn
SELECT royalty FROM book WHERE book.isbn = X

-- get threshold_num given isbn
SELECT threshold_num FROM book WHERE book.isbn = X

-- get num_in_stock given isbn
SELECT num_in_stock FROM book WHERE book.isbn = X

-- get publisher email, given book isbn
SELECT email_address
            FROM book
            JOIN publisher
            ON book.p_id = publisher.p_id
            WHERE book.isbn = X

-- number of books to request from publisher given we are low on stock
SELECT sum(cart_books.isbn) 
            FROM checkout 
            JOIN cart 
            ON checkout.cart_id = cart.cart_id 
            JOIN cart_books 
            ON cart.cart_id = cart_books.cart_id 
            WHERE month = current_month - 1 
            AND isbn = isbn_to_order

-- fetches most recently added address_id
SELECT address_id FROM address ORDER BY address_id DESC LIMIT 1

-- fetch registerd billing and shipping id's given customer id
SELECT shipping_address_id, billing_address_id FROM customer WHERE c_id = $1

-- fetch the most recent checkout 
SELECT check_id FROM checkout ORDER BY check_id DESC LIMIT 1



--------------------------------------- FROM LoginRegisterQueries.rb ---------------------------------------

-- Gets all the customer data given a username and password.
SELECT * FROM customer
      NATURAL JOIN customer_email
      NATURAL JOIN customer_phone_number
      JOIN address AS s_ad ON customer.shipping_address_id = s_ad.address_id
      JOIN address AS b_ad ON customer.billing_address_id = b_ad.address_id
      JOIN region AS r_s ON r_s.postal_code = s_ad.postal_code
      JOIN region AS r_b ON r_b.postal_code = b_ad.postal_code
      WHERE username=$1 AND password=$2



--------------------------------------- FROM OrdersQueries.rb ---------------------------------------

-- returns info on all orders given customer id
SELECT order_number, status, cl_city, cl_country, day, month, year
      FROM orders
      JOIN checkout ON orders.check_id = checkout.check_id
      WHERE c_id = $1

-- returns titles and prices of all books in order based on order number
SELECT title, price
      FROM orders
      JOIN checkout ON orders.check_id = checkout.check_id
      JOIN cart ON checkout.cart_id = cart.cart_id
      JOIN cart_books ON cart_books.cart_id = cart.cart_id
      JOIN book ON book.isbn = cart_books.isbn
      WHERE order_number = $1



--------------------------------------- FROM SearchForBooksQueries.rb ---------------------------------------

-- The main query in this file is very complicated, as it cases, branches, and has 3 subqueries which
-- all branch off on conditions which I cannot express in pure .sql
-- I am going to skip porting that one into this file as it would not be able to format correctly
-- please go visit the file defined above to see the details of this query and its flow of logic.