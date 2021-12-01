# RELATION SCHEMAS

'*' = FK

**book**(<ins>ISBN</ins>, p_id*, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

**cart**(<ins>c_id</ins>)

**cart_books**(<ins>c_id</ins>, <ins>ISBN</ins>)

**author_phone_number**( <ins>a_id</ins>, <ins>phone_number</ins>)

**owner_phone_number**( <ins>o_id</ins>, <ins>phone_number</ins>)

**customer_phone_number**( <ins>c_id</ins>, <ins>phone_number</ins>)

**author**(<ins>a_id</ins>, first_name, last_name, email_address)

**book_authors**(<ins>ISBN</ins>, <ins>a_id</ins>)

**publisher**(<ins>p_id</ins>, address_id*, name, email_address, bank_account , account_value)

**publisher_phone_number**( <ins>p_id</ins>, <ins>phone_number</ins>)

**owner**( <ins>o_id</ins>, first_name, last_name, email_address, username, password)

**reports**( <ins>r_id</ins>, o_id*, day, month, year, report_type, result)

**order**( <ins>order_number</ins> , o_id*, check_id*, cl_city, cl_country, status)

**customer**( <ins>c_id</ins>, shipping_address_id*, billing_address_id*, first_name, last_name, email_address, username, password)

**checkout**( <ins>check_id</ins>, billing_address*, shipping_address*, c_id*, cart_id*, day, month, year)

**address**(<ins>address_id</ins>, street_number, street_name, city, country, postal_code)