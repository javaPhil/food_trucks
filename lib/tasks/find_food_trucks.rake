namespace :food_trucks do
require 'task_helpers/FoodTruckHelper'

  desc "Simple command to find open food trucks"
  task :find_open_trucks => :environment do
    puts "Finding Open food trucks!"
    DEFAULT_LIMIT = 10
    DEFAULT_OFFSET = 0
    current_offset = 0

    all_open_food_trucks = FoodTruckHelper.get_todays_open_food_trucks
    last_page_offset = (all_open_food_trucks.length / DEFAULT_LIMIT).round

    FoodTruckHelper.pretty_print_results(all_open_food_trucks, DEFAULT_LIMIT, DEFAULT_OFFSET)

    while current_offset <= last_page_offset do
      begin
        if current_offset == 0
          STDOUT.puts "Page #{current_offset+1} - (N)ext page, (E)xit"
        elsif last_page_offset <= current_offset
          STDOUT.puts "Page #{current_offset+1} - (P)revious page, (E)xit"
        else
          STDOUT.puts "Page #{current_offset+1} - (N)ext page, (P)revious page, (E)xit"
        end
        input = STDIN.gets.strip.downcase
      end until %w(n p e).include?(input)

      if input == "n"
        if last_page_offset <= current_offset
          # show last page if user tries to go forward
          FoodTruckHelper.pretty_print_results(all_open_food_trucks, DEFAULT_LIMIT, current_offset)
        else
          current_offset += 1
          FoodTruckHelper.pretty_print_results(all_open_food_trucks, DEFAULT_LIMIT, current_offset)
        end

      elsif input == "p"
        if current_offset > 0
          current_offset -= 1
          FoodTruckHelper.pretty_print_results(all_open_food_trucks, DEFAULT_LIMIT, current_offset)
        else
          FoodTruckHelper.pretty_print_results(all_open_food_trucks, DEFAULT_LIMIT, current_offset)
        end
      else
        # do nothing
        break
      end
    end


  end

end
