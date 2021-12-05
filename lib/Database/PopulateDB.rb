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

    def create_address_region_pair_and_return_aid
      postal_code = generate_random_postal_code
      @con.exec_params(GenStatements.gen_region_statement, [postal_code, Faker::Address.city, Faker::Address.country])
      @con.exec_params(GenStatements.gen_address_statement, [Faker::Address.building_number, Faker::Address.street_name, postal_code])
      address_id = prep_result('address_id', 'address', 'postal_code', postal_code).values[0][0]
      return address_id
    end

    def create_author_author_phone_author_email_triple_and_return_aid
      email = Faker::Internet.email
      phone = Faker::Base.numerify('(###) ### ####')
      if is_valid_insert("author_email", "email_address", email)
        @con.exec_params(GenStatements.gen_author_email_statement, [email, Faker::Name.first_name, Faker::Name.last_name])
        @con.exec_params(GenStatements.gen_author_statement, [email]) 
        author_id = prep_result('a_id', 'author', 'email_address', email).values[0][0].to_i
        @con.exec_params(GenStatements.gen_author_phone_number, [author_id, phone])
        return author_id
      end
      return NULL # not sure what to do in this case
    end

    def create_publisher_publisher_bank_publisher_email_publisher_phone_address_and_return_p_id
      email = Faker::Internet.email
      phone = Faker::Base.numerify('(###) ### ####')
      if is_valid_insert("publisher_email", "email_address", email)
        @con.exec_params(GenStatements.gen_publisher_email_statement, [email, Faker::Company.name])
        @con.exec_params(GenStatements.gen_publisher_bank_statement, [Faker::Number.random({min: 10000, max: 1000000})])
        # bank_account = prep_result('bank_account', 'publisher_bank').last.values
        # @con.exec_params(GenStatements.gen_publisher_bank_statement, [Faker::Number.random({min: 10000, max: 1000000})])

      end
    end


    def execute
      puts "INSERTING INTO DB"

      #generate the default owner
      @con.exec_params(GenStatements.gen_owner_email_statement, ['ahmedelroby@gmail.com', 'Ahmed', 'ElRoby'])
      @con.exec_params(GenStatements.gen_owner_statement, ['ahmedelroby@gmail.com', 'ElRoby', 'COMP3005'])

      #generates address->region pairs. links to nothing currently
      20.times{
        puts 'adding address->region pairs... '
        create_address_region_pair_and_return_aid
      }

      #generates author->(author_email & author_phone_number), author not currently linked to books.
      20.times{
        puts "author->(author_email & author_phone_number)..."
        create_author_author_phone_author_email_triple_and_return_aid
      }
      puts "INSERTION COMPLETE"
    end
  end
end