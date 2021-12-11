require 'pg'
require 'faker'
require 'io/console'

module Owner
  class AddBookQueries
    def initialize(con)
      @con = con
    end

    def get_publishers
      @con.exec("SELECT p_id, publisher_email.name  FROM publisher JOIN publisher_email ON publisher.email_address = publisher_email.email_address")
    end
  end
end