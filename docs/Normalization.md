# Normalization

## Normalization into 3NF

1) If there exists FD's in F<sub>c</sub> such that $\alpha$ <sub>1</sub> &rarr; $\beta$ <sub>1</sub> and $\alpha$ <sub>1</sub> &rarr; $\beta$ <sub>2</sub>, remove them all and replace them with their union $\alpha$ <sub>1</sub> &rarr; $\beta$ <sub>1</sub> $\beta$ <sub>2</sub>
2) Test each FD in F<sub>c</sub> for extraneous attributes, remove those that are found from F<sub>c</sub>
3) For each FD in F<sub>c</sub>, derive R<sub>i</sub> = $\alpha$ $\beta$
4) Check that atleast one of the derived relations R<sub>i</sub> contains a candidate key for R. If none do, derive one that does
5) Check if any relation R<sub>j</sub> is a subset of any other relation R<sub>k</sub>, remove R<sub>j</sub>

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

1) Since there exists only 1 FD, no union can be formed
2) Since there exists only 1 FD, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {ISBN, p_id, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold}
4) ISBN from R<sub>1</sub> is a candidate key for the relation book
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation book therefore satisfies 3NF, and is in good normal form. No decomposition required.

**book**(<ins>ISBN</ins>, p_id*, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

---
### Cart

cart = {c_id}

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {c_id} as c_id &rarr; c_id is the only inferrable (trivial) FD
4) c_id from R<sub>1</sub> is a candidate key for the relation cart
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation cart therefore satisfies 3NF, and is in good normal form. No decomposition required.

**cart**(<ins>c_id</ins>)

---
### Cart_Books

cart_books = (c_id, ISBN)

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {c_id, ISBN} as (c_id, ISBN) &rarr; (c_id, ISBN) is the only inferrable (trivial) FD
4) (c_id, ISBN) from R<sub>1</sub> is a candidate key for the relation cart_books
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation cart_books therefore satisfies 3NF, and is in good normal form. No decomposition required.

**cart_books**(<ins>c_id</ins>, <ins>ISBN</ins>)

---
### Author_Phone_Number

author_phone_number = (a_id, phone_number)

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {a_id, phone_number} as (a_id, phone_number) &rarr; (a_id, phone_number) is the only inferrable (trivial) FD
4) (a_id, phone_number) from R<sub>1</sub> is a candidate key for the relation author_phone_number
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation author_phone_number therefore satisfies 3NF, and is in good normal form. No decomposition required.

**author_phone_number**( <ins>a_id</ins>, <ins>phone_number</ins>)

---
### Owner_Phone_Number

owner_phone_number = (o_id, phone_number)

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {o_id, phone_number} as (o_id, phone_number) &rarr; (o_id, phone_number) is the only inferrable (trivial) FD
4) (o_id, phone_number) from R<sub>1</sub> is a candidate key for the relation owner_phone_number
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation owner_phone_number therefore satisfies 3NF, and is in good normal form. No decomposition required.

**owner_phone_number**( <ins>o_id</ins>, <ins>phone_number</ins>)

---
### Customer_Phone_Number

customer_phone_number = (c_id, phone_number)

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {c_id, phone_number} as (c_id, phone_number) &rarr; (c_id, phone_number) is the only inferrable (trivial) FD
4) (c_id, phone_number) from R<sub>1</sub> is a candidate key for the relation customer_phone_number
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation customer_phone_number therefore satisfies 3NF, and is in good normal form. No decomposition required.

**customer_phone_number**( <ins>c_id</ins>, <ins>phone_number</ins>)

---
### Author

author = {a_id, first_name, last_name, email_address}

F = {

&nbsp;&nbsp; a_id &rarr; (first_name, last_name, email_address),

&nbsp;&nbsp; email_address &rarr; a_id

}

F<sub>c</sub> = F

F<sub>c</sub> = {

&nbsp;&nbsp; a_id &rarr; (first_name, last_name, email_address),

&nbsp;&nbsp; email_address &rarr; a_id

}

1) No two FD's have the same $\alpha$ , therefore no union can be formed
2) Testing for Extraneous Attributes

   * Case for a_id &rarr; (first_name, last_name, email_address)

      *  Is first_name extraneous in a_id &rarr; (first_name, last_name, email_address) ?

          * Replace a_id &rarr; (first_name, last_name, email_address) with a_id &rarr; (last_name, email_address)

          * a_id<sup>+</sup> = { } 

            1) a_id &rarr; a_id : a_id<sup>+</sup> = { a_id }
            2) a_id &rarr; (last_name, email_address) : a_id<sup>+</sup> = { a_id, last_name, email_address }

              * Nothing else can be inferred, since first_name is not in a_id<sup>+</sup>, first_name is
                not an extraneous attribute, and must stay in the FD.

      *  Is last_name extraneous in a_id &rarr; (first_name, last_name, email_address) ?

          * Replace a_id &rarr; (first_name, last_name, email_address) with a_id &rarr; (first_name, email_address)

          * a_id<sup>+</sup> = { } 

            1) a_id &rarr; a_id : a_id<sup>+</sup> = { a_id }
            2) a_id &rarr; (first_name, email_address) : a_id<sup>+</sup> = { a_id, first_name, email_address }

              * Nothing else can be inferred, since last_name is not in a_id<sup>+</sup>, last_name is
                not an extraneous attribute, and must stay in the FD.

      *  Is email_address extraneous in a_id &rarr; (first_name, last_name, email_address) ?

          * Replace a_id &rarr; (first_name, last_name, email_address) with a_id &rarr; (first_name, last_name)

          * a_id<sup>+</sup> = { } 

            1) a_id &rarr; a_id : a_id<sup>+</sup> = { a_id }
            2) a_id &rarr; (first_name, last_name) : a_id<sup>+</sup> = { a_id, first_name, last_name }

              * Nothing else can be inferred, since email_address is not in a_id<sup>+</sup>, email_address is
                not an extraneous attribute, and must stay in the FD.


    * Case for email_address &rarr; a_id

      * Since there is only 1 attribute on the LHS and 1 attribute on the RHS, none of the attributes can be extraneous


3) Therefore, R<sub>1</sub> = {a_id, first_name, last_name, email_address} and R<sub>2</sub> = {a_id, email_address}
4) a_id from R<sub>1</sub> is a candidate key for the relation customer_phone_number
5) R<sub>2</sub> is a subset of R<sub>1</sub> , and therefore can be deleted. 

The relation author therefore satisfies 3NF, and is in good normal form. No decomposition required.

**author**(<ins>a_id</ins>, first_name, last_name, email_address)

---
### Book_Authors

book_authors = (ISBN, a_id)

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {ISBN, a_id} as (ISBN, a_id) &rarr; (ISBN, a_id) is the only inferrable (trivial) FD
4) (ISBN, a_id) from R<sub>1</sub> is a candidate key for the relation book_authors
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation book_authors therefore satisfies 3NF, and is in good normal form. No decomposition required.

**book_authors**(<ins>ISBN</ins>, <ins>a_id</ins>)

---
### Publisher

publisher = (p_id, address_id*, name, email_address, bank_account, account_value)

F = {

  &nbsp;&nbsp; p_id &rarr; (address_id, name, email_address, bank_account , account_value),

  &nbsp;&nbsp; email_address &rarr; (name, p_id),

  &nbsp;&nbsp; bank_account &rarr; account_value

}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; p_id &rarr; (address_id, name, email_address, bank_account , account_value),

  &nbsp;&nbsp; email_address &rarr; (name, p_id),

  &nbsp;&nbsp; bank_account &rarr; account_value

}

1) No two FD's have the same $\alpha$ , therefore no union can be formed
2) Testing for Extraneous Attributes

    * Case for p_id &rarr; (address_id, name, email_address, bank_account , account_value)

        * Is address_id extraneous in p_id &rarr; (address_id, name, email_address, bank_account , account_value) ?

            * Replace p_id &rarr; (address_id, name, email_address, bank_account , account_value) with p_id &rarr; (name, email_address, bank_account , account_value)

            * p_id<sup>+</sup> = { } 

              1) p_id &rarr; p_id : p_id<sup>+</sup> = { p_id }
              2) p_id &rarr; (name, email_address, bank_account , account_value) : p_id<sup>+</sup> = { p_id, name, email_address, bank_account , account_value }

                * Nothing else can be inferred, since address_id is not in p_id<sup>+</sup>, address_id is not an extraneous attribute, and must stay in the FD

        * Is name extraneous in p_id &rarr; (address_id, name, email_address, bank_account , account_value) ?

            * Replace p_id &rarr; (address_id, name, email_address, bank_account , account_value) with p_id &rarr; (address_id, email_address, bank_account , account_value)

            * p_id<sup>+</sup> = { } 

              1) p_id &rarr; p_id : p_id<sup>+</sup> = { p_id }
              2) p_id &rarr; (address_id, email_address, bank_account , account_value) : p_id<sup>+</sup> = { p_id, address_id, email_address, bank_account , account_value }
              3) email_address &rarr; (name, p_id) : p_id<sup>+</sup> = { p_id, address_id, email_address, bank_account, account_value, name }

                * Since name can be found in p_id<sup>+</sup> , it is extraneous. We will replace the FD p_id &rarr; (address_id, name, email_address, bank_account , account_value) with the FD p_id &rarr; (address_id, email_address, bank_account , account_value) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover
                
                F<sub>c</sub> = {

                  p_id --> (address_id, email_address, bank_account , account_value),

                  email_address --> (name, p_id),

                  bank_account --> account_value

                }

        * Is email_address extraneous in p_id &rarr; (address_id, email_address, bank_account, account_value) ?

            * Replace p_id &rarr; (address_id, email_address, bank_account, account_value) with p_id &rarr; (address_id, bank_account, account_value)

            * p_id<sup>+</sup> = { } 

              1) p_id &rarr; p_id : p_id<sup>+</sup> = { p_id }
              2) p_id &rarr; (address_id, bank_account, account_value) : p_id<sup>+</sup> = { p_id, address_id, bank_account, account_value }

                * Nothing else can be inferred, since email_address is not in p_id<sup>+</sup>, email_address is not an extraneous attribute, and must stay in the FD

        * Is bank_account extraneous in p_id &rarr; (address_id, email_address, bank_account, account_value) ?

            * Replace p_id &rarr; (address_id, email_address, bank_account, account_value) with p_id &rarr; (address_id, email_address, account_value)

            * p_id<sup>+</sup> = { } 

              1) p_id &rarr; p_id : p_id<sup>+</sup> = { p_id }
              2) p_id &rarr; (address_id, email_address, account_value) : p_id<sup>+</sup> = { p_id, address_id, email_address, account_value }
              3) email_address &rarr; (name, p_id) : p_id<sup>+</sup> = { p_id, address_id, email_address, account_value, name }

                * Nothing else can be inferred, since bank_account is not in p_id<sup>+</sup>, bank_account is not an extraneous attribute, and must stay in the FD

        * Is account_value extraneous in p_id &rarr; (address_id, email_address, bank_account, account_value) ?

            * Replace p_id &rarr; (address_id, email_address, bank_account, account_value) with p_id &rarr; (address_id, email_address, bank_account)

            * p_id<sup>+</sup> = { } 

              1) p_id &rarr; p_id : p_id<sup>+</sup> = { p_id }
              2) p_id &rarr; (address_id, email_address, bank_account) : p_id<sup>+</sup> = { p_id, address_id, email_address, bank_account }
              3) email_address &rarr; (name, p_id) : p_id<sup>+</sup> = { p_id, address_id, email_address, bank_account, name }
              4) bank_account &rarr; account_value : p_id<sup>+</sup> = { p_id, address_id, email_address, bank_account, name, account_value }

                * Since account_value can be found in p_id<sup>+</sup> , it is extraneous. We will replace the FD p_id &rarr; (address_id, email_address, bank_account, account_value) with the FD p_id &rarr; (address_id, email_address, bank_account) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  p_id --> (address_id, email_address, bank_account),

                  email_address --> (name, p_id),

                  bank_account --> account_value

                }

    * Case for email_address &rarr; (name, p_id)

        * Is name extraneous in email_address &rarr; (name, p_id) ?

            * Replace email_address &rarr; (name, p_id) with email_address &rarr; (p_id)

            * email_address<sup>+</sup> = { }

              1) email_address &rarr; email_address : email_address<sup>+</sup> = { email_address }
              2) email_address &rarr; p_id : email_address<sup>+</sup> = { email_address, p_id }
              3) p_id &rarr; (address_id, email_address, bank_account) : email_address<sup>+</sup> = { email_address, p_id, address_id, bank_account }
              4) bank_account &rarr; account_value : email_address<sup>+</sup> = { email_address, p_id, address_id, bank_account, account_value }

                * Nothing else can be inferred, since name is not in email_address<sup>+</sup>, name is not an extraneous attribute, and must stay in the FD

        * Is p_id extraneous in email_address &rarr; (name, p_id) ?

            * Replace email_address &rarr; (name, p_id) with email_address &rarr; (name)

            * email_address<sup>+</sup> = { }

              1) email_address &rarr; email_address : email_address<sup>+</sup> = { email_address }
              2) email_address &rarr; name : email_address<sup>+</sup> = { email_address, name}

                * Nothing else can be inferred, since p_id is not in email_address<sup>+</sup>, p_id is not an extraneous attribute, and must stay in the FD

    * Case for bank_account &rarr; account_value

        * Since there is only 1 attribute on either the LHS and RHS, no attributes in this FD can be extraneous.

3) Therefore, R<sub>1</sub> = {p_id, address_id, email_address, bank_account}, R<sub>2</sub> = {email_address, name, p_id}, and R<sub>3</sub> = {bank_account, account_value }
4) p_id from R<sub>1</sub> is a candidate key for the relation book_authors
5) None of R<sub>1</sub>, R<sub>2</sub>, or R<sub>3</sub> are subsets of one another, so we must decompose the relation publsiher into three new relations. These will be the schemas for the new relations...

**publisher** (<ins>p_id</ins>, address_id*, email_address*, bank_account*)

**publisher_email** (<ins>email_address</ins>, name, p_id)

**publisher_bank** (<ins>bank_account</ins>, account_value)



---
### Publisher_Phone_Number

publisher_phone_number = {p_id, phone_number}

F = { }

F<sub>c</sub> = F

F<sub>c</sub> = { }

1) Since there exists 0 FD's, no union can be formed
2) Since there exists 0 FD's, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {p_id, phone_number} as (p_id, phone_number) &rarr; (p_id, phone_number) is the only inferrable (trivial) FD
4) (p_id, phone_number) from R<sub>1</sub> is a candidate key for the relation publisher_phone_number
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation publisher_phone_number therefore satisfies 3NF, and is in good normal form. No decomposition required.

**publisher_phone_number**( <ins>p_id</ins>, <ins>phone_number</ins>)

---
### Owner

owner = {o_id, first_name, last_name, email_address, username, password}

F = {

  &nbsp;&nbsp; o_id &rarr; (first_name, last_name, email_address, username, password),

  &nbsp;&nbsp; email_address &rarr; (first_name, last_name, o_id),

  &nbsp;&nbsp; (username, password) &rarr; o_id

}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; o_id &rarr; (first_name, last_name, email_address, username, password),

  &nbsp;&nbsp; email_address &rarr; (first_name, last_name, o_id),

  &nbsp;&nbsp; (username, password) &rarr; o_id

}

1) No two FD's have the same $\alpha$ , therefore no union can be formed
2) Testing for Extraneous Attributes

    * Case for o_id &rarr; (first_name, last_name, email_address, username, password)

        * Is first_name extraneous in o_id &rarr; (first_name, last_name, email_address, username, password) ?

            * Replace o_id &rarr; (first_name, last_name, email_address, username, password) with o_id &rarr; (last_name, email_address, username, password)

            * o_id<sup>+</sup> = { } 

              1) o_id &rarr; o_id : o_id<sup>+</sup> = { o_id }
              2) o_id &rarr; (last_name, email_address, username, password) : o_id<sup>+</sup> = { o_id, last_name, email_address, username, password }
              3) email_address &rarr; (first_name, last_name, o_id) : o_id<sup>+</sup> = { o_id, last_name, email_address, username, password, first_name }

                * Since first_name can be found in o_id<sup>+</sup> , it is extraneous. We will replace the FD o_id &rarr; (first_name, last_name, email_address, username, password) with the FD o_id &rarr; (last_name, email_address, username, password) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  o_id --> (last_name, email_address, username, password),

                  email_address --> (first_name, last_name, o_id),

                  (username, password) --> o_id

                }

        * Is last_name extraneous in o_id &rarr; (last_name, email_address, username, password) ?

            * Replace o_id &rarr; (last_name, email_address, username, password) with o_id &rarr; (email_address, username, password)

            * o_id<sup>+</sup> = { } 

              1) o_id &rarr; o_id : o_id<sup>+</sup> = { o_id }
              2) o_id &rarr; (email_address, username, password) : o_id<sup>+</sup> = { o_id, email_address, username, password }
              3) email_address &rarr; (first_name, last_name, o_id) : o_id<sup>+</sup> = { o_id, email_address, username, password, first_name, last_name}

                * Since last_name can be found in o_id<sup>+</sup> , it is extraneous. We will replace the FD o_id &rarr; (last_name, email_address, username, password) with the FD o_id &rarr; (email_address, username, password) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  o_id --> (email_address, username, password),

                  email_address --> (first_name, last_name, o_id),

                  (username, password) --> o_id

                }

        * Is email_address extraneous in o_id &rarr; (email_address, username, password) ?

            * Replace o_id &rarr; (email_address, username, password) with o_id &rarr; (username, password)

            * o_id<sup>+</sup> = { } 

              1) o_id &rarr; o_id : o_id<sup>+</sup> = { o_id }
              2) o_id &rarr; (username, password) : o_id<sup>+</sup> = { o_id, username, password }

                * Nothing else can be inferred, since email_address is not in o_id<sup>+</sup>, email_address is not an extraneous attribute, and must stay in the FD

        * Is username extraneous in o_id &rarr; (email_address, username, password) ?

            * Replace o_id &rarr; (email_address, username, password) with o_id &rarr; (email_address, password)

            * o_id<sup>+</sup> = { } 

              1) o_id &rarr; o_id : o_id<sup>+</sup> = { o_id }
              2) o_id &rarr; (email_address, password) : o_id<sup>+</sup> = { o_id, email_address, password }
              3) email_address &rarr; (first_name, last_name, o_id) : p_id<sup>+</sup> = {o_id, email_address, password, first_name, last_name }

                * Nothing else can be inferred, since username is not in o_id<sup>+</sup>, username is not an extraneous attribute, and must stay in the FD

        * Is password extraneous in o_id &rarr; (email_address, username, password) ?

            * Replace o_id &rarr; (email_address, username, password) with o_id &rarr; (email_address, username)

            * o_id<sup>+</sup> = { } 

              1) o_id &rarr; o_id : o_id<sup>+</sup> = { o_id }
              2) o_id &rarr; (email_address, username) : o_id<sup>+</sup> = { o_id, email_address, username }
              3) email_address &rarr; (first_name, last_name, o_id) : p_id<sup>+</sup> = {o_id, email_address, username, first_name, last_name }

                * Nothing else can be inferred, since password is not in o_id<sup>+</sup>, password is not an extraneous attribute, and must stay in the FD

    * Case for email_address &rarr; (first_name, last_name, o_id)

        * Is first_name extraneous in email_address &rarr; (first_name, last_name, o_id) ?

            * Replace email_address &rarr; (first_name, last_name, o_id) with email_address &rarr; (last_name, o_id)

            * email_address<sup>+</sup> = { } 

              1) email_address &rarr; email_address : email_address<sup>+</sup> = { email_address }
              2) email_address &rarr; (last_name, o_id) : email_address<sup>+</sup> = {email_address, last_name, o_id }
              3) o_id &rarr; (email_address, username, password) : email_address<sup>+</sup> = {email_address, last_name, o_id, username, password }

                * Nothing else can be inferred, since first_name is not in email_address<sup>+</sup>, first_name is not an extraneous attribute, and must stay in the FD

        * Is last_name extraneous in email_address &rarr; (first_name, last_name, o_id) ?

            * Replace email_address &rarr; (first_name, last_name, o_id) with email_address &rarr; (first_name, o_id)

            * email_address<sup>+</sup> = { } 

              1) email_address &rarr; email_address : email_address<sup>+</sup> = { email_address }
              2) email_address &rarr; (first_name, o_id) : email_address<sup>+</sup> = {email_address, first_name, o_id }
              3) o_id &rarr; (email_address, username, password) : email_address<sup>+</sup> = {email_address, first_name, o_id, username, password }

                * Nothing else can be inferred, since last_name is not in email_address<sup>+</sup>, last_name is not an extraneous attribute, and must stay in the FD

    * Case for (username, password) &rarr; o_id

        * Is username extraneous in (username, password) &rarr; o_id ?

            * Can we imply password &rarr; o_id

            * password<sup>+</sup> = { } 

                1) password &rarr; password : password<sup>+</sup> = { password }
            
                * Nothing else can be inferred, since password alone cannot imply o_id, username must stay in the FD.

        * Is password extraneous in (username, password) &rarr; o_id ?

            * Can we imply username &rarr; o_id

            * username<sup>+</sup> = { } 

                1) username &rarr; username : username<sup>+</sup> = { username }
            
                * Nothing else can be inferred, since username alone cannot imply o_id, password must stay in the FD.

3) Therefore, R<sub>1</sub> = {o_id, email_address, username, password}, R<sub>2</sub> = {email_address, first_name, last_name, o_id}, and R<sub>3</sub> = {o_id, username, password}.
4) o_id from R<sub>1</sub> is a candidate key for the relation owner
5) R<sub>3</sub> is a subset of R<sub>1</sub>, so it will be deleted, R<sub>1</sub> and R<sub>2</sub> will persist and be the product of this decomposition... 

**owner**( <ins>o_id</ins>, email_address*, username, password)

**owner_email**( <ins>email_address</ins>, first_name, last_name)

---
### Reports

reports = (r_id, o_id, day, month, year, report_type, result)

F = {

  &nbsp;&nbsp; r_id &rarr; (o_id, day, month, year, report_type, result)
  
}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; r_id &rarr; (o_id, day, month, year, report_type, result)

}

1) Since there exists only 1 FD, no union can be formed
2) Since there exists only 1 FD, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {r_id, o_id, day, month, year, report_type, result}
4) r_id from R<sub>1</sub> is a candidate key for the relation reports
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation reports therefore satisfies 3NF, and is in good normal form. No decomposition required.

**reports**( <ins>r_id</ins>, o_id*, day, month, year, report_type, result)

---
### Order

order = (order_number, o_id, check_id, cl_city, cl_country, status)

F = {

  &nbsp;&nbsp; order_number &rarr; (o_id, check_id, cl_city, cl_country, status)
  
}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; order_number &rarr; (o_id, check_id, cl_city, cl_country, status)

}

1) Since there exists only 1 FD, no union can be formed
2) Since there exists only 1 FD, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {order_number, o_id, check_id, cl_city, cl_country, status}
4) order_number from R<sub>1</sub> is a candidate key for the relation order
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation order therefore satisfies 3NF, and is in good normal form. No decomposition required.

**order**( <ins>order_number</ins> , o_id*, check_id*, cl_city, cl_country, status)

---
### Customer 

customer = (c_id, shipping_address_id*, billing_address_id*, first_name, last_name, email_address, username, password)

F = {

  &nbsp;&nbsp; c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password),
  
  &nbsp;&nbsp; email_address &rarr; (first_name, last_name, c_id),

  &nbsp;&nbsp; (username, password) &rarr; c_id

}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password),
  
  &nbsp;&nbsp; email_address &rarr; (first_name, last_name, c_id),

  &nbsp;&nbsp; (username, password) &rarr; c_id

}

1) No two FD's have the same $\alpha$ , therefore no union can be formed
2) Testing for Extraneous Attributes

    * Case for c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password)

        * Is shipping_address_id extraneous in c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) with c_id &rarr; ( billing_address_id, first_name, last_name, email_address, username, password)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( billing_address_id, first_name, last_name, email_address, username, password) : c_id<sup>+</sup> = { c_id, billing_address_id, first_name, last_name, email_address, username, password }

                * Nothing else can be inferred, since shipping_address_id is not in c_id<sup>+</sup>, shipping_address_id is not an extraneous attribute, and must stay in the FD

        * Is billing_address_id extraneous in c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) with c_id &rarr; ( shipping_address_id, first_name, last_name, email_address, username, password)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( shipping_address_id, first_name, last_name, email_address, username, password) : c_id<sup>+</sup> = { c_id, shipping_address_id, first_name, last_name, email_address, username, password }

                * Nothing else can be inferred, since billing_address_id is not in c_id<sup>+</sup>, billing_address_id is not an extraneous attribute, and must stay in the FD

        * Is first_name extraneous in c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) with c_id &rarr; ( shipping_address_id, billing_address, last_name, email_address, username, password)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( shipping_address_id, billing_address, last_name, email_address, username, password) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, last_name, email_address, username, password }
              3) email_address &rarr; (first_name, last_name, c_id) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, last_name, email_address, username, password, first_name }

                * Since first_name can be found in c_id<sup>+</sup> , it is extraneous. We will replace the FD c_id &rarr; (shipping_address_id, billing_address_id, first_name, last_name, email_address, username, password) with the FD c_id &rarr; ( shipping_address_id, billing_address, last_name, email_address, username, password) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  c_id --> (shipping_address_id, billing_address_id, last_name, email_address, username, password),
                  
                  email_address --> (first_name, last_name, c_id),

                  (username, password) --> c_id

                }

        * Is last_name extraneous in c_id &rarr; (shipping_address_id, billing_address_id, last_name, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, last_name, email_address, username, password) with c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( shipping_address_id, billing_address, email_address, username, password) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, email_address, username, password }
              3) email_address &rarr; (first_name, last_name, c_id) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, email_address, username, password, first_name, last_name }

                * Since last_name can be found in c_id<sup>+</sup> , it is extraneous. We will replace the FD c_id &rarr; (shipping_address_id, billing_address_id, last_name, email_address, username, password) with the FD c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  c_id --> (shipping_address_id, billing_address_id, email_address, username, password),
                  
                  email_address --> (first_name, last_name, c_id),

                  (username, password) --> c_id

                }

        * Is email_address extraneous in c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) with c_id &rarr; (shipping_address_id, billing_address_id, username, password)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( shipping_address_id, billing_address, username, password) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, username, password }

                *  Nothing else can be inferred, since email_address is not in c_id<sup>+</sup>, email_address is not an extraneous attribute, and must stay in the FD

        * Is username extraneous in c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) with c_id &rarr; (shipping_address_id, billing_address_id, email_address, password)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( shipping_address_id, billing_address, email_address, password) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, email_address, password }
              3) email_address --> (first_name, last_name, c_id) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, email_address, password, first_name, last_name }

                *  Nothing else can be inferred, since username is not in c_id<sup>+</sup>, username is not an extraneous attribute, and must stay in the FD

        * Is password extraneous in c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) ?

            * Replace c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) with c_id &rarr; (shipping_address_id, billing_address_id, email_address, username)

            * c_id<sup>+</sup> = { } 

              1) c_id &rarr; c_id : c_id<sup>+</sup> = { c_id }
              2) c_id &rarr; ( shipping_address_id, billing_address, email_address, username) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, email_address, username }
              3) email_address --> (first_name, last_name, c_id) : c_id<sup>+</sup> = { c_id, shipping_address_id, billing_address, email_address, username, first_name, last_name }

                *  Nothing else can be inferred, since password is not in c_id<sup>+</sup>, password is not an extraneous attribute, and must stay in the FD

    * Case for email_address &rarr; (first_name, last_name, c_id)

        * Is first_name extraneous in email_address &rarr; (first_name, last_name, c_id) ?

            * Replace email_address &rarr; (first_name, last_name, c_id) with email_address &rarr; (last_name, c_id)

            * email_address<sup>+</sup> = { } 

              1) email_address &rarr; email_address : email_address<sup>+</sup> = { email_address }
              2) email_address &rarr; (last_name, c_id) : email_address<sup>+</sup> = { email_address, last_name, c_id }
              3) c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) : email_address<sup>+</sup> = { email_address, last_name, c_id, shipping_address_id, billing_address_id, username, password }

                * Nothing else can be inferred, since first_name is not in email_address<sup>+</sup>, first_name is not an extraneous attribute, and must stay in the FD

        * Is last_name extraneous in email_address &rarr; (first_name, last_name, c_id) ?

            * Replace email_address &rarr; (first_name, last_name, c_id) with email_address &rarr; (first_name, c_id)

            * email_address<sup>+</sup> = { } 

              1) email_address &rarr; email_address : email_address<sup>+</sup> = { email_address }
              2) email_address &rarr; (first_name, c_id) : email_address<sup>+</sup> = { email_address, first_name, c_id }
              3) c_id &rarr; (shipping_address_id, billing_address_id, email_address, username, password) : email_address<sup>+</sup> = { email_address, first_name, c_id, shipping_address_id, billing_address_id, username, password }

                * Nothing else can be inferred, since last_name is not in email_address<sup>+</sup>, last_name is not an extraneous attribute, and must stay in the FD

    * Case for (username, password) &rarr; c_id

        * Is username extraneous in (username, password) &rarr; c_id ?

            * Can we imply password &rarr; c_id ?

            * password<sup>+</sup> = { } 

              1) password &rarr; password : password<sup>+</sup> = { password }

                * Nothing else can be inferred, since password alone cannot imply c_id, username is not an extraneous attribute, and must stay in the FD

        * Is password extraneous in (username, password) &rarr; c_id ?

            * Can we imply username &rarr; c_id ?

            * username<sup>+</sup> = { } 

              1) username &rarr; username : username<sup>+</sup> = { username }

                * Nothing else can be inferred, since username alone cannot imply c_id, password is not an extraneous attribute, and must stay in the FD

3) Therefore, R<sub>1</sub> = {c_id, shipping_address_id, billing_address_id, email_address, username, password}, R<sub>2</sub> = {email_address, first_name, last_name, c_id}, and R<sub>3</sub> = {username, password, c_id}.
4) c_id from R<sub>1</sub> is a candidate key for the relation customer
5) R<sub>3</sub> is a subset of R<sub>1</sub>, so it will be deleted, but R<sub>1</sub> and R<sub>2</sub> will persist and be the product of this decomposition...

**customer**( <ins>c_id</ins>, shipping_address_id*, billing_address_id*, email_address*, username, password)

**customer_email** (<ins>email_address</ins> , first_name, last_name, c_id)

---
### Checkout 

checkout = (check_id, billing_address, shipping_address, c_id, cart_id, day, month, year)

F = {

  &nbsp;&nbsp; check_id &rarr; (shipping_address_id, billing_address_id, c_id, cart_id, day, month, year)

}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; check_id &rarr; (shipping_address_id, billing_address_id, c_id, cart_id, day, month, year)

}

1) Since there exists only 1 FD, no union can be formed
2) Since there exists only 1 FD, none of the attributes can be extraneous, therefore nothing to remove from F<sub>c</sub>
3) Therefore, R<sub>1</sub> = {check_id, shipping_address_id, billing_address_id, c_id, cart_id, day, month, year}
4) check_id from R<sub>1</sub> is a candidate key for the relation checkout
5) R<sub>1</sub> is the only relation, and therefore is not a subset of any other relation

The relation checkout therefore satisfies 3NF, and is in good normal form. No decomposition required.

**checkout**( <ins>check_id</ins>, billing_address*, shipping_address*, c_id*, cart_id*, day, month, year)

---
### Address

address = (address_id, street_number, street_name, city, country, postal_code)

F = {

  &nbsp;&nbsp; address_id &rarr; (street_number, street_name, city, country, postal_code),

  &nbsp;&nbsp; postal_code &rarr; (city, country)

}

F<sub>c</sub> = F

F<sub>c</sub> = {

  &nbsp;&nbsp; address_id &rarr; (street_number, street_name, city, country, postal_code),

  &nbsp;&nbsp; postal_code &rarr; (city, country)

}

1) No two FD's have the same $\alpha$ , therefore no union can be formed
2) Testing for Extraneous Attributes

    * Case for address_id &rarr; (street_number, street_name, city, country, postal_code)

        * Is street_number extraneous in address_id &rarr; (street_number, street_name, city, country, postal_code) ?

            * Replace address_id &rarr; (street_number, street_name, city, country, postal_code) with address_id &rarr; (street_name, city, country, postal_code)

            * address_id<sup>+</sup> = { } 

              1) address_id &rarr; address_id : address_id<sup>+</sup> = { address_id }
              2) address_id &rarr; (street_name, city, country, postal_code) : address_id<sup>+</sup> = { address_id, street_name, city, country, postal_code }

                * Nothing else can be inferred, since street_number is not in address_id<sup>+</sup>, street_number is not an extraneous attribute, and must stay in the FD

        * Is street_name extraneous in address_id &rarr; (street_number, street_name, city, country, postal_code) ?

            * Replace address_id &rarr; (street_number, street_name, city, country, postal_code) with address_id &rarr; (street_number, city, country, postal_code)

            * address_id<sup>+</sup> = { } 

              1) address_id &rarr; address_id : address_id<sup>+</sup> = { address_id }
              2) address_id &rarr; (street_number, city, country, postal_code) : address_id<sup>+</sup> = { address_id, street_number, city, country, postal_code }

                * Nothing else can be inferred, since street_name is not in address_id<sup>+</sup>, street_name is not an extraneous attribute, and must stay in the FD

        * Is city extraneous in address_id &rarr; (street_number, street_name, city, country, postal_code) ?

            * Replace address_id &rarr; (street_number, street_name, city, country, postal_code) with address_id &rarr; (street_number, street_name, country, postal_code)

            * address_id<sup>+</sup> = { } 

              1) address_id &rarr; address_id : address_id<sup>+</sup> = { address_id }
              2) address_id &rarr; (street_number, street_name, country, postal_code) : address_id<sup>+</sup> = { address_id, street_number, street_name, country, postal_code }
              3) postal_code &rarr; (city, country) : address_id<sup>+</sup> = { address_id, street_number, street_name, country, postal_code, city }

                * Since city can be found in address_id<sup>+</sup> , it is extraneous. We will replace the FD address_id &rarr; (street_number, street_name, city, country, postal_code) with the FD address_id &rarr; (street_number, street_name, country, postal_code) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  address_id --> (street_number, street_name, country, postal_code),

                  postal_code --> (city, country)

                }

        * Is country extraneous in address_id &rarr; (street_number, street_name, city, country, postal_code) ?

            * Replace address_id &rarr; (street_number, street_name, country, postal_code) with address_id &rarr; (street_number, street_name, postal_code)

            * address_id<sup>+</sup> = { } 

              1) address_id &rarr; address_id : address_id<sup>+</sup> = { address_id }
              2) address_id &rarr; (street_number, street_name, postal_code) : address_id<sup>+</sup> = { address_id, street_number, street_name, postal_code }
              3) postal_code &rarr; (city, country) : address_id<sup>+</sup> = { address_id, street_number, street_name, postal_code, city, country }

                * Since country can be found in address_id<sup>+</sup> , it is extraneous. We will replace the FD address_id &rarr; (street_number, street_name, country, postal_code) with the FD address_id &rarr; (street_number, street_name, postal_code) in F<sub>c</sub>

                * Therefore, the new adjusted Canonical Cover

                F<sub>c</sub> = {

                  address_id --> (street_number, street_name, postal_code),

                  postal_code --> (city, country)

                }

        * Is postal_code extraneous in address_id &rarr; (street_number, street_name, postal_code) ?

            * Replace address_id &rarr; (street_number, street_name, postal_code) with address_id &rarr; (street_number, street_name)

            * address_id<sup>+</sup> = { } 

              1) address_id &rarr; address_id : address_id<sup>+</sup> = { address_id }
              2) address_id &rarr; (street_number, street_name) : address_id<sup>+</sup> = { address_id, street_number, street_name}

                * Nothing else can be inferred, since postal_code is not in address_id<sup>+</sup>, postal_code is not an extraneous attribute, and must stay in the FD

    * Case for postal_code &rarr; (city, country)

        * Is city extraneous in postal_code &rarr; (city, country) ?

            * Replace postal_code &rarr; (city, country) with postal_code &rarr; (country)

            * postal_code<sup>+</sup> = { } 

              1) postal_code &rarr; postal_code : postal_code<sup>+</sup> = { postal_code }
              2) postal_code &rarr; (country) : postal_code<sup>+</sup> = { postal_code, country }

                * Nothing else can be inferred, since city is not in postal_code<sup>+</sup>, city is not an extraneous attribute, and must stay in the FD

        * Is country extraneous in postal_code &rarr; (city, country) ?

            * Replace postal_code &rarr; (city, country) with postal_code &rarr; (city)

            * postal_code<sup>+</sup> = { } 

              1) postal_code &rarr; postal_code : postal_code<sup>+</sup> = { postal_code }
              2) postal_code &rarr; (city) : postal_code<sup>+</sup> = { postal_code, city }

                * Nothing else can be inferred, since country is not in postal_code<sup>+</sup>, country is not an extraneous attribute, and must stay in the FD

3) Therefore, R<sub>1</sub> = {address_id, street_number, street_name, postal_code} and R<sub>2</sub> = {postal_code, city, country}.
4) address_id from R<sub>1</sub> is a candidate key for the relation address
5) Neither of theese relations are subset of one another, so R<sub>1</sub> and R<sub>2</sub> will persist and be the product of this decomposition...

**address**(<ins>address_id</ins>, street_number, street_name, postal_code*)

**region**(<ins>postal_code</ins>, city, country)

---


# The Resulting Relational Schemas

**book**(<ins>ISBN</ins>, p_id*, title, genre, royalty, num_pages, price, cost, sales, num_in_stock, threshold_num, num_sold)

**cart**(<ins>c_id</ins>)

**cart_books**(<ins>c_id</ins>, <ins>ISBN</ins>)

**author_phone_number**( <ins>a_id</ins>, <ins>phone_number</ins>)

**owner_phone_number**( <ins>o_id</ins>, <ins>phone_number</ins>)

**customer_phone_number**( <ins>c_id</ins>, <ins>phone_number</ins>)

**author**(<ins>a_id</ins>, first_name, last_name, email_address)

**book_authors**(<ins>ISBN</ins>, <ins>a_id</ins>)

**publisher** (<ins>p_id</ins>, address_id*, email_address*, bank_account*)

**publisher_email** (<ins>email_address</ins>, name, p_id)

**publisher_bank** (<ins>bank_account</ins>, account_value)

**publisher_phone_number**( <ins>p_id</ins>, <ins>phone_number</ins>)

**owner**( <ins>o_id</ins>, email_address*, username, password)

**owner_email**( <ins>email_address</ins>, first_name, last_name)

**reports**( <ins>r_id</ins>, o_id*, day, month, year, report_type, result)

**order**( <ins>order_number</ins> , o_id*, check_id*, cl_city, cl_country, status)

**customer**( <ins>c_id</ins>, shipping_address_id*, billing_address_id*, email_address*, username, password)

**customer_email** (<ins>email_address</ins> , first_name, last_name, c_id)

**checkout**( <ins>check_id</ins>, billing_address*, shipping_address*, c_id*, cart_id*, day, month, year)

**address**(<ins>address_id</ins>, street_number, street_name, postal_code*)

**region**(<ins>postal_code</ins>, city, country)