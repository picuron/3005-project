# RELATION SCHEMAS AFTER 3NF

'*' = FK

**book**(<ins>ISBN</ins>, p_id*, title, genre, royalty, num_pages, price, cost, num_in_stock, threshold_num, num_sold)

**cart**(<ins>cart_id</ins>)

**cart_books**(<ins>cart_id</ins>, <ins>ISBN</ins>)

**author_phone_number**( <ins>a_id</ins>, <ins>phone_number</ins>)

**owner_phone_number**( <ins>o_id</ins>, <ins>phone_number</ins>)

**customer_phone_number**( <ins>c_id</ins>, <ins>phone_number</ins>)

**author**(<ins>a_id</ins>, email_address)

**author_email**(<ins>email_address</ins>, first_name, last_name)

**book_authors**(<ins>ISBN</ins>, <ins>a_id</ins>)

**publisher** (<ins>p_id</ins>, address_id*, email_address*, bank_account*)

**publisher_email** (<ins>email_address</ins>, name)

**publisher_bank** (<ins>bank_account</ins>, account_value)

**publisher_phone_number**( <ins>p_id</ins>, <ins>phone_number</ins>)

**owner**( <ins>o_id</ins>, email_address*, username, password)

**owner_email**( <ins>email_address</ins>, first_name, last_name)

**reports**( <ins>r_id</ins>, o_id*, day, month, year, report_type, result)

**order**( <ins>order_number</ins> , o_id*, check_id*, cl_city, cl_country, status)

**customer**( <ins>c_id</ins>, shipping_address_id*, billing_address_id*, email_address*, username, password)

**customer_email** (<ins>email_address</ins> , first_name, last_name)

**checkout**( <ins>check_id</ins>, billing_address_id*, shipping_address_id*, c_id*, cart_id*, day, month, year)

**address**(<ins>address_id</ins>, street_number, street_name, postal_code*)

**region**(<ins>postal_code</ins>, city, country)