namespace :food_trucks do
require 'task_helpers/FoodTruckHelper'

  desc "Simple command to find open food trucks"
  task :find_open_trucks => :environment do
    puts "Finding Open food trucks!"
    DEFAULT_LIMIT = 10
    DEFAULT_OFFSET = 0
    current_offset = 0

    all_open_food_trucks = FoodTruckHelper.get_todays_open_food_trucks

    FoodTruckHelper.pretty_print_results(all_open_food_trucks, DEFAULT_LIMIT, DEFAULT_OFFSET)


  end

end
