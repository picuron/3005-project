require_relative '../GenStatements.rb'

module Client
  class OrdersQueries
    def initialize(con)
      @con = con
    end

    def fetch_user_orders(user)
      statement = "SELECT order_number, status, cl_city, cl_country, day, month, year "\
      "FROM orders "\
      "JOIN checkout ON orders.check_id = checkout.check_id "\
      "WHERE c_id = $1"
      @con.exec_params(statement, [user])
    end

    def fetch_books_in_order(order_number)
      statement = "SELECT title, price "\
      "FROM orders "\
      "JOIN checkout ON orders.check_id = checkout.check_id "\
      "JOIN cart ON checkout.cart_id = cart.cart_id "\
      "JOIN cart_books ON cart_books.cart_id = cart.cart_id "\
      "JOIN book ON book.isbn = cart_books.isbn "\
      "WHERE order_number = $1"
      @con.exec_params(statement, [order_number])
    end

  end
end