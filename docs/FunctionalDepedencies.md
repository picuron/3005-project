# Functional Dependencies 

---

**F<sub>book**</sub> = {
  
  &nbsp;&nbsp; ISBN &rarr; p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold
  
  }

---

**F<sub>author**</sub> = {

  &nbsp;&nbsp; a_id &rarr; first_name, last_name, email_address

  &nbsp;&nbsp; email_address &rarr; a_id
 
}

---

**F<sub>publisher**</sub> = {

  &nbsp;&nbsp; p_id &rarr; address_id, name, email_address, bank_account , account_value

  &nbsp;&nbsp; email_address &rarr; name, p_id

  &nbsp;&nbsp; bank_account &rarr; account_value

}

---

**F<sub>owner**</sub> = {

  &nbsp;&nbsp; o_id &rarr; first_name, last_name, email_address, username, password

  &nbsp;&nbsp; email_address &rarr; first_name, last_name, o_id

  &nbsp;&nbsp; username, password &rarr; c_id

}

---

**F<sub>reports**</sub> = {

  &nbsp;&nbsp; r_id &rarr; o_id, day, month, year, report_type, result
  
}

---

**F<sub>order**</sub> = {

  &nbsp;&nbsp; order_number &rarr; o_id, check_id, cl_city, cl_country, status
  
}

---

**F<sub>customer**</sub> = {

  &nbsp;&nbsp; c_id &rarr; shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password
  
  &nbsp;&nbsp; email_address &rarr; first_name, last_name, c_id

  &nbsp;&nbsp; username, password &rarr; c_id

}

---

**F<sub>checkout**</sub> = {

  &nbsp;&nbsp; check_id &rarr; shipping_address_id, billing_address_id, c_id, cart_id, day, month, year

}

---

**F<sub>address**</sub> = {

  &nbsp;&nbsp; address_id &rarr; street_number, street_name, city, country, postal_code

  &nbsp;&nbsp; postal_code &rarr; city, country

}