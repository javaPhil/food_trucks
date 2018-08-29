module FoodTruckHelper
  require 'net/http'
  require 'json'


  def self.get_todays_open_food_trucks
    url = URI.parse("http://data.sfgov.org/resource/bbb8-hzi6.json")

    req = Net::HTTP::Get.new(url.to_s)
    req.set_form_data({dayofweekstr: Time.now.strftime("%A")})
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    if res.code == "200"
      json_results = JSON.parse(res.body)
      return parsed_api_response(json_results)
    else
      puts "Error fetching results. Code: #{res.code}"
      # return an error to the console
      return {}
    end

  end

  def self.parsed_api_response(response)
    open_food_trucks = []

    response.each do |truck|
      truckStart = Time.parse(truck["starttime"])
      truckEnd = Time.parse(truck["endtime"])
      if Time.now >= truckStart && Time.now < truckEnd
        open_food_trucks.push({
                                  name: truck["applicant"],
                                  location: truck["location"],
                                  desc: truck["optionaltext"]
                              }
        )
      end
    end

    puts "RESULTS COUNT: #{open_food_trucks.length}"
    return open_food_trucks.sort_by!{|truck| truck["name"]}

  end

  def self.pretty_print_results(all_food_trucks, limit, offset)
    # columns: NAME | LOCATION | DESCRIPTION

    puts "NAME | LOCATION | DESCRIPTION"
    puts "-----------------------------"
    min = offset * limit
    max = min + limit
    food_trucks = all_food_trucks[min, max]
    food_trucks.each do |truck|
      puts "#{truck[:name]} | #{truck[:location]} | #{truck[:desc]}"
    end
    puts "-----------------------------"

    return food_trucks
  end

end