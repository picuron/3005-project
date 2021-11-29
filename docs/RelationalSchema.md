# RELATION SCHEMAS


**book**(<ins>ISBN</ins>, pub_id, title, genre, publisher_id, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

**cart**(<ins>c_id</ins>)

**cart_books**(<ins>c_id</ins>, <ins>ISBN</ins>)

**person_phone_number**( <ins>p_id</ins>, <ins>phone_number</ins>)

**author**(<ins>p_id</ins>, first_name, last_name, email_address)

**book_authors**(<ins>ISBN</ins>, <ins>p_id</ins>)

**publisher**(<ins>pub_id</ins>, name, street_name, city, country, postal_code, email_address, bank_account , account_value)

**publisher_phone_number**( <ins>pub_id</ins>, <ins>phone_number</ins>)

**owner**( <ins>p_id</ins>, first_name, last_name, email_address, username, password)

**reports**( <ins>r_id</ins>,  p_id, day, month, year, report_type, result)

**order**( <ins>order_number</ins> , p_id, c_id, current_location, status, )

**customer**( <ins>p_id</ins>,  first_name, last_name, email_address, username, password, rb_street_name, rb_city, rb_country, rb_postal_code, rs_street_name, rs_city, rs_country, rs_postal_code)

**checkout**( <ins>c_id</ins>, billing_address, shipping_address, day, month, year, p_id, c_id,)