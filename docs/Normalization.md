# Normalization

## Normalization into 3NF

1) If there exists FD's in F<sub>c</sub> such that $\alpha$ <sub>1</sub> &rarr; $\beta$ <sub>1</sub> and $\alpha$ <sub>1</sub> &rarr; $\beta$ <sub>2</sub>, remove them all and replace them with their union $\alpha$ <sub>1</sub> &rarr; $\beta$ <sub>1</sub> $\beta$ <sub>2</sub>.
2) Test each FD in F<sub>c</sub> for extraneous attributes, remove those that are found from F<sub>c</sub>
3) For each FD in F<sub>c</sub>, derive R<sub>i</sub> = $\alpha$ $\beta$.
4) Check that atleast one of the derived relations R<sub>i</sub> contains a candidate key for R. If none do, derive one that does.
5) Check if any relation R<sub>j</sub> is a subset of any other relation R<sub>k</sub>, remove R<sub>j</sub>.

---
### Book 

book = {ISBN, p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold}

F = {
  
  &nbsp;&nbsp; ISBN &rarr; (p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; ISBN &rarr; (p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

}

1) No two FD's in F<sub>c</sub> have the same $\alpha$ .
2) Case for ISBN &rarr; (p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Is p_id extraneous ?
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Replace ISBN &rarr; (p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold) with ISBN &rarr; (title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold), is p_id still a part of ISBN<sup>+</sup>?

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN<sup>+</sup> = { }
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1) ISBN &rarr; ISBN : ISBN<sup>+</sup> = {ISBN}
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2) ISBN &rarr; (title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold) : ISBN<sup>+</sup> = {ISBN, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold}
Nothing else can be inferred. Since p_id is not a member of ISBN<sup>+</sup>, it is not extraneous, and must remain in the FD.




---
### Cart

**cart**(<ins>c_id</ins>)

---
### Cart_Books

**cart_books**(<ins>c_id</ins>, <ins>ISBN</ins>)

---
### Author_Phone_Number

**author_phone_number**( <ins>a_id</ins>, <ins>phone_number</ins>)

---
### Owner_Phone_Number

**owner_phone_number**( <ins>o_id</ins>, <ins>phone_number</ins>)

---
### Customer_Phone_Number

**customer_phone_number**( <ins>c_id</ins>, <ins>phone_number</ins>)

---
### Author

**author**(<ins>a_id</ins>, first_name, last_name, email_address)

---
### Book_Authors

**book_authors**(<ins>ISBN</ins>, <ins>a_id</ins>)

---
### Publisher

**publisher**(<ins>p_id</ins>, address_id*, name, email_address, bank_account, account_value)

---
### Publisher_Phone_Number

**publisher_phone_number**( <ins>p_id</ins>, <ins>phone_number</ins>)

---
### Owner

**owner**( <ins>o_id</ins>, first_name, last_name, email_address, username, password)

---
### Reports

**reports**( <ins>r_id</ins>, o_id*, day, month, year, report_type, result)

---
### Order

**order**( <ins>order_number</ins> , o_id*, check_id*, cl_city, cl_country, status)

---
### Customer 

**customer**( <ins>c_id</ins>, shipping_address_id*, billing_address_id*, first_name, last_name, email_address, username, password)

---
### Checkout 

**checkout**( <ins>check_id</ins>, billing_address*, shipping_address*, c_id*, cart_id*, day, month, year)

---
### Address

**address**(<ins>address_id</ins>, street_number, street_name, city, country, postal_code)

---