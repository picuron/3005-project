module Client
  class LoginRegisterQueries
    def initialize(con)
      @con = con
    end

    def fetch_user(username, password)
      statement = "SELECT * FROM customer "\
      "NATURAL JOIN customer_email "\
      "NATURAL JOIN customer_phone_number "\
      "JOIN address AS s_ad ON customer.shipping_address_id = s_ad.address_id "\
      "JOIN address AS b_ad ON customer.billing_address_id = b_ad.address_id "\
      "JOIN region AS r_s ON r_s.postal_code = s_ad.postal_code "\
      "JOIN region AS r_b ON r_b.postal_code = b_ad.postal_code "\
      "WHERE username=$1 AND password=$2"
      @con.exec_params(statement, [username, password])
    end

    def register_user(
      email,
      username,
      password,
      first_name,
      last_name,
      phone_num,
      shiping_street_num,
      shipping_street_name,
      shipping_postal_code,
      shipping_city,
      shipping_country,
      billing_street_num,
      billing_street_name,
      billing_postal_code,
      billing_city,
      billing_country
    )

    end

  end
end