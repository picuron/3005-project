require_relative '../../HelperLib/Helper.rb'
require_relative '../../Database/ClientQueries/LoginRegisterQueries.rb'

module Client
  class LoginRegister
    attr_accessor :cart
    attr_accessor :session
    attr_accessor :user
    attr_accessor :state
    def initialize(session, cart, user)
      @session = session
      @cart = cart
      @user = user
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
      Helper.clear
    end

    def fetch_user(username, password)
      con = @session.db_connection_open
      user = LoginRegisterQueries.new(con).fetch_user(username, password)
      @session.db_connection_close(con)
      return user
    end

    def login
      while true
        Helper.clear
        puts "Username: "
        username = gets.chomp
        puts "Password: "
        password = gets.chomp
        fetched_user = fetch_user(username, password)
        if fetched_user.values.length != 0
          Helper.clear
          puts "Welcome #{username}"
          @user = fetched_user.values[0][0]
          break
        else
          Helper.clear
          puts "Incorrect username or Password"
          puts "[1] - Try again"
          puts "[2] - Quit"
          input = gets.chomp
          case input
          when "1"
            #loop
          when "2"
            Helper.clear
            break
          else
            Helper.invalid_entry_display
          end
        end
      end
      return @user
    end

    def generate_new_user(user_info_hash)
      con = @session.db_connection_open
      user = LoginRegisterQueries.new(con).generate_new_user(user_info_hash)
      @session.db_connection_close(con)
      return user
    end

    def register
      new_user = {}
      Helper.clear
      puts "Welcome new-comer, provide the following information and we will build you an account"
      puts "Username: "
      new_user["username"] = gets.chomp
      puts "Password: "
      new_user["password"] = gets.chomp
      puts "Email-address: "
      new_user["email_address"] = gets.chomp
      puts "First Name: "
      new_user["first_name"] = gets.chomp
      puts "Last Name: "
      new_user["last_name"] = gets.chomp
      puts "Phone number in the format XXXXXXXXXX."
      puts "If you have more then one, press \'enter\' and put additional numbers on a new line."
      puts "Press \'enter\' again when done. "
      array_of_phone_numbers = Array.new
      while true
        phone_number = gets.chomp
        if phone_number == ''
          break
        elsif phone_number.length != 10
          puts "Sorry, phone numbers should be 10 numbers long"
        elsif phone_number.to_i == 0
          puts "Sorry, ohone numbers should only contain numericals"
        else
          phone_number.insert(0, '(').insert(4, ')').insert(5, ' ').insert(9, ' ')
          array_of_phone_numbers.push(phone_number)
        end
      end
      puts array_of_phone_numbers
      new_user['phone_numbers'] = array_of_phone_numbers
      puts "Billing street number: "
      new_user['billing_street_number'] = gets.chomp
      puts "Billing street name: "
      new_user['billing_street_name'] = gets.chomp
      puts "Billing postal code: "
      new_user['billing_postal_code'] = gets.chomp
      puts "Billing city: "
      new_user['billing_city'] = gets.chomp
      puts "Billing country: "
      new_user['billing_country'] = gets.chomp
      puts "Is your Shiping addres the same as your billing address ?"
      puts "[1] - Yes\n[2] - No"
      while true
        input = gets.chomp
        case input
          when '1'
            new_user['shipping_street_number'] = new_user['billing_street_number']
            new_user['shipping_street_name'] = new_user['billing_street_name']
            new_user['shipping_postal_code'] = new_user['billing_postal_code']
            new_user['shipping_city'] = new_user['billing_city']
            new_user['shipping_country'] = new_user['billing_country']
            break
          when '2'
            puts "Silling street number: "
            new_user['shipping_street_number'] = gets.chomp
            puts "Silling street name: "
            new_user['shipping_street_name'] = gets.chomp
            puts "Shipping postal code: "
            new_user['shipping_postal_code'] = gets.chomp
            puts "Shipping city: "
            new_user['shipping_city'] = gets.chomp
            puts "Shipping country: "
            new_user['shipping_country'] = gets.chomp
            break
          else
            Helper.invalid_entry_display
        end
      end
      @user = generate_new_user(new_user)
      return @user
    end
  end
end