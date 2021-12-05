require 'pg'
require 'io/console'
require 'faker'
require_relative './GenStatements.rb'

module Database
  class PopulateDB
    def initalize(con)
      @con = con
      execute
    end

    private
    def generate_random_postal_code
      (1..3).map{
        "#{('A'..'Z').to_a[rand(26)]}#{(0..9).to_a[rand(9)]}"
      }.join
    end

    def prep_result(select_, from, where, equals)
      query = "SELECT #{select_} FROM #{from} WHERE #{where}=$1"
      query_result = @con.exec_params(query, [equals])
    end

    def is_valid_insert(table_name, attribute_name, value_name)

      query = "SELECT COUNT(*) FROM #{table_name} WHERE #{attribute_name}=$1"
      query_result = @con.exec_params(query, [value_name])
      
      if(query_result.values[0][0].to_i == 0)
        return true
      end
      false
    end

    def execute
      puts "INSERTING INTO DB"

      #generate the default owner
      @con.exec_params(GenStatements.gen_owner_email_statement, ['ahmedelroby@gmail.com', 'Ahmed', 'ElRoby'])
      @con.exec_params(GenStatements.gen_owner_statement, ['ahmedelroby@gmail.com', 'ElRoby', 'COMP3005'])

      #generates address->region pairs. links to nothing currently
      20.times{
        puts 'adding address->region pairs... '
        postal_code = generate_random_postal_code
        @con.exec_params(GenStatements.gen_region_statement, [postal_code, Faker::Address.city, Faker::Address.country])
        @con.exec_params(GenStatements.gen_address_statement, [Faker::Address.building_number, Faker::Address.street_name, postal_code])
      }

      #generates author->(author_email & author_phone_number), author not currently linked to books.
      20.times{
        puts "author->(author_email & author_phone_number)..."
        email = Faker::Internet.email
        phone = Faker::PhoneNumber.phone_number

        if is_valid_insert("author_email", "email_address", email)
          @con.exec_params(GenStatements.gen_author_email_statement, [email, Faker::Name.first_name, Faker::Name.last_name])
          @con.exec_params(GenStatements.gen_author_statement, [email]) 
          auth_id = prep_result('a_id', 'author', 'email_address', email).values[0][0].to_i
          @con.exec_params(GenStatements.gen_author_phone_number, [auth_id, phone])
        end

      }
      puts "INSERTION COMPLETE"
    end
  end
end