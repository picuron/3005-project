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

--------------------------------------- FROM AddBookQueries.rb ---------------------------------------

-- Gets all publishers and their names 
SELECT p_id, publisher_email.name
      FROM publisher
      JOIN publisher_email ON publisher.email_address = publisher_email.email_address

--------------------------------------- FROM AddBook.rb ---------------------------------------

-- Checks if a given publisher name can be added, as names must be unique. If it returns a 0 count, there are no other
-- publishers with that given name, and is thus unique so that name can be used for a new publisher
SELECT COUNT(*) 
      FROM publisher_email 
      WHERE name = $1

-- Checks if a given publisher email can be added, as emails must be unique. If it returns a 0 count, there are no other
-- publishers with that given email, and is thus unique so that name can be used for a new publisher
SELECT COUNT(*)
      FROM publisher_email
      WHERE email_address = $1

-- Checks if a given publisher bank number can be added, as bank numbers must be unique. If it returns a 0 count, there are no other
-- publishers with that given bank number, and is thus unique so that bank number can be used for a new publisher
SELECT COUNT(*)
      FROM publisher_bank
      WHERE bank_account = $1

-- Checks if a given postal code can be added, as postal code must be unique. If it returns a 0 count, there are no identical
-- postal codes, and is thus unique so that a new one can be created out of it
SELECT COUNT(*)
      FROM region
      WHERE postal_code=$1

-- Checks if a given author email can be added, as author emails must be unique. If it returns a 0 count, there are no identical
-- author emails, and is thus unique so that a new one can be created out of it
SELECT COUNT(*)
      FROM author_email
      WHERE email_address=$1

-- This is used to get the latest address_id that was added to the database. We recognize this is not ideal in a system with many users using this at once
-- more on that in the report.
SELECT address_id 
      FROM address 
      ORDER BY address_id
      DESC LIMIT 1

-- Used to get the latest p_id (publisher ID) that was added to the DB
SELECT p_id 
      FROM publisher 
      ORDER BY p_id 
      DESC LIMIT 1

-- Used to check if an ISBN is already in our database. Since ISBNs must be unique, if the count is not 0, that means the ISBN already exists
-- so we cannot add another ISBN with that name
SELECT COUNT(*)
      FROM book 
      WHERE isbn = $1

-- Used to check if a book title is already in the database. Titles must be unique, so if this returns a number that is not 0, the title already exists
-- and thus we prevent another book with the same title being added
SELECT COUNT(*)
      FROM book
      WHERE title = $1

-- Get author IDs and their names
SELECT a_id, author_email.first_name, author_email.last_name 
      FROM author 
      JOIN author_email ON author.email_address = author_email.email_address

-- Used to get the latest author ID that was added to the database
SELECT a_id
      FROM author 
      ORDER BY a_id 
      DESC LIMIT 1

--------------------------------------- FROM FulfillOrdersQueries.rb ---------------------------------------

-- Gets an order numbers for a given order status
SELECT order_number 
      FROM orders 
      WHERE status=$1

--------------------------------------- FROM FulfillOrders.rb ---------------------------------------

-- Select the owner ID of the owner with the given username and password
SELECT o_id
      FROM owner
      WHERE username=$1 AND password=$2

--------------------------------------- FROM GenerateReports.rb ---------------------------------------

-- Get the sum of sales (price * num_sold) for all books
SELECT SUM(price*num_sold)
      FROM book

-- Get the sum of the cost (cost * num_sold) for all books
SELECT SUM(cost*num_sold) 
      FROM book

-- Select the owner ID of the owner with the given username and password
SELECT o_id
      FROM owner
      WHERE username=$1 AND password=$2

-- Get the total sales for each authopr
SELECT author_email.first_name, author_email.last_name, 
      SUM(price*num_sold) 
      FROM book
      JOIN author_books 
      ON book.isbn = author_books.isbn
      JOIN author 
      ON author_books.a_id = author.a_id
      JOIN author_email
      ON author.email_address = author_email.email_address
      GROUP BY author_email.first_name, author_email.last_name

-- Get the total sales grouped by genre
SELECT genre, SUM(price*num_sold)
      FROM book
      GROUP BY genre

--------------------------------------- FROM RemoveBook.rb ---------------------------------------

-- Get the isbn and title for all books
SELECT isbn, title
      FROM book

-- Check if a given ISBN exists in our database. If count = 0, that ISBN does not exist in our DB.
SELECT COUNT(*) 
      FROM book
      WHERE isbn = $1