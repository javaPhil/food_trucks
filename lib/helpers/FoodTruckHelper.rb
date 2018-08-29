module FoodTruckHelper
  require 'net/http'


  def getFoodTrucks(params)

    # params {}
    # day of week | default: TODAY
    # current page number | default: 1
    # limit - results per page | default: 10

    url = URI.parse('http://data.sfgov.org/resource/bbb8-hzi6.json')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.body
  end

end