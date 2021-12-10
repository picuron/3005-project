require 'pg'
require 'faker'
require 'io/console'

module Owner
  class FulfillOrdersQueries
    def initialize(con)
      @con = con
    end

    def get_orders
      statement = "SELECT order_number FROM orders WHERE status=$1"
      @con.exec_params(statement, ["UNFULFILLED"])
    end

    def fulfill_order(order_number, owner_id)
      statement = "UPDATE orders SET status = $1, o_id = $2, cl_city = $3, cl_country = $4 WHERE order_number = $5"
      @con.exec_params(statement, ["SHIPPED", owner_id, Faker::Address.city, Faker::Address.country, order_number])
    end
  end
end