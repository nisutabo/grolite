require 'excon'
require 'json'
require 'faker'


def get_weather_data #args will be seed_date, state and city
  day = 86400
  seed_date = (Time.now)
  today = Time.now
  result = {'maxhumidity': [], 'minhumidity': [], 'maxtempf': [], 'mintempf': [], 'meantempf': []}

  until seed_date.strftime("%Y/%m/%d") == today.strftime("%Y/%m/%d")

    search_date = seed_date.year.to_s + (sprintf '%02d', seed_date.month).to_s + (sprintf '%02d', seed_date.day).to_s
    history = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/history_#{search_date}/q/CA/San_Francisco.json", :persistent => true)
    dailysummary = JSON.parse(history.body)['history']['dailysummary'][0]
    result[:maxtempf] << dailysummary['maxtempi']
    result[:mintempf] << dailysummary['mintempi']
    result[:meantempf] << dailysummary['meantempi']
    result[:maxhumidity] << dailysummary['maxhumidity']
    result[:minhumidity] << dailysummary['minhumidity']
    seed_date += day

  end

    hourly = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/hourly/q/NY/New_York.json", :persistent => true)
    today_tempf = JSON.parse(hourly.body)['hourly_forecast'].map{|m| m['temp']['english']}
    today_humidity = JSON.parse(hourly.body)['hourly_forecast'].map{|m| m['humidity']}
    today_hours = JSON.parse(hourly.body)['hourly_forecast'].map{|m| m['FCTTIME']['hour']}
    result[:today_tempf] = today_tempf
    result[:today_humidity] = today_humidity
    result[:today_hours] = today_hours


    current = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/conditions/q/NY/New_York.json", :persistent => true)
    current_temp = JSON.parse(current.body)['current_observation']['temp_f']
    current_humidity = JSON.parse(current.body)['current_observation']['relative_humidity']
    current_time = JSON.parse(current.body)['current_observation']['observation_time_rfc822'].split(' ')[4]
    result[:current_time] = current_time
    result[:current_temp] = current_temp
    result[:current_humidity] = current_humidity

    astronomy = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/astronomy/q/NY/New_York.json", :persistent => true)
    sunrise = JSON.parse(astronomy.body)['moon_phase']['sunrise']['hour'].to_i
    sunset = JSON.parse(astronomy.body)['moon_phase']['sunset']['hour'].to_i
    result[:sun_hours] = sunset - sunrise



puts result
end


get_weather_data

# def get_weatherbit
#
#   today = Time.now.strftime("%Y/%m/%d").gsub!("/","-")
#   yesterday = (Time.now - 86400).strftime("%Y/%m/%d").gsub!("/","-")
#
#   history = Excon.get("https://api.weatherbit.io/v2.0/history/daily?city=New_York,NY&start_date=#{yesterday}&end_date=#{today}&key=c5ff710c64cd4b1ea8016f272abd120e", :persistent => true)
#   summary = JSON.parse(history.body)
#   # direct_normal_solar_irradiance = summary['data'][0]['dni']
#   # footcandles = direct_normal_solar_irradiance / 0.101
#   # micromol_per_sqm_per_sec = footcandles * 0.02
#   # micromol_per_sqm_per_day = micromol_per_sqm_per_sec * 3600 * 13
#   # dli = (micromol_per_sqm_per_day/1000000).round(3)
#
#
#
#   puts summary
# end
#
# get_weatherbit



#   def status_check
#
#     day = 86400
#     seed_date = Time.now
#     germination_days = (21 * day)
#     propagation_days = (42 * day)
#     production_days = (42 * day)
#
#     propagation_date = (seed_date + germination_days)
#     production_date = (propagation_date + propagation_days)
#     harvest_date = (production_date + production_days)
#
#     number = Faker::Number.between(1,90)
#     random_day = (seed_date + (number * day))
#
#     if random_day < propagation_date
#       return 'nursery'
#     elsif ((random_day >= propagation_date) && (random_day < production_date))
#       return 'propagation'
#     elsif ((random_day >= production_date) && (random_day < harvest_date))
#       return 'production'
#     else
#       return 'ready for harvest'
#     end
#
#
#   end
#
#
# status_check


# def float_faker
#   n = Faker::Number.between(1,3)
#   d = Faker::Number.decimal(0,1).to_f
#   puts n + d
# end
#
# float_faker
