module Helper
  def wait 
    puts "\nPress enter to continue\n"
    input = gets.chomp
  end
  module_function :wait

  def clear
    puts "\e[2J\e[f"
  end
  module_function :clear
end