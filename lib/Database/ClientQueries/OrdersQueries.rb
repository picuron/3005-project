require_relative '../GenStatements.rb'

module Client
  class OrdersQueries
    def initialize(con)
      @con = con
    end

    def fetch_user_orders(user)
      statement = "SELECT order_number FROM orders NATURAL JOIN checkout WHERE c_id = $1"
      @con.exec_params(statement, [user])
    end
  end
end