class Api::V1::GroupsController < ApplicationController

  def index
    @groups = Group.all
    render json: @groups
  end

  def show
    @group = Group.find(params[:id])
    return render json: @group
  end

  def create

    day = 86400
    seed_date = Time.now
    propagation_date = seed_date + (day * params[:germination_days].to_i)
    production_date = propagation_date + (day * params[:propagation_days].to_i)
    harvest_date = production_date + (day * params[:production_days].to_i)
    @crop = Crop.find(params[:crop_id].to_i)
    crop_name = @crop.name
    crop_group = @crop.crop_group
    scientific_name = @crop.scientific_name
    @user = User.find(params[:user_id].to_i)
    location = @user.location

    @group = Group.new(crop_id: params[:crop_id], crop_name: crop_name, crop_group: crop_group,
      scientific_name: scientific_name, user_id: params[:user_id], seed_date: seed_date,
      propagation_date: propagation_date, production_date: production_date, harvest_date: harvest_date,
      germination_days: params[:germination_days].to_i, propagation_days: params[:propagation_days].to_i,
      production_days: params[:production_days].to_i, harvested: false, expected_harvest_lbs: params[:expected_harvest_lbs],
      location: location, trays: params[:trays])
    if @group.save
      return render json: @group
    else
      return render json: {errors: @group.errors.full_messages}, status: 422
    end
  end

  def update
    @group = Group.find(params[:id])
    day = 86400
    seed_date = @group.seed_date
    propagation_date = seed_date + (day * params[:germination_days].to_i)
    production_date = propagation_date + (day * params[:propagation_days].to_i)
    harvest_date = production_date + (day * params[:production_days].to_i)

    @group.update(propagation_date: propagation_date, production_date: production_date, harvest_date: harvest_date,
      germination_days: params[:germination_days].to_i, propagation_days: params[:propagation_days].to_i,
      production_days: params[:production_days].to_i)
    if @group.save
      render json: @group
    else
      render json: {errors: @account.errors.full_messages}, status: 422
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    @groups = Group.all
    render json: @groups
  end


  def data #params will have group id
    @group = Group.find(params[:id])
    @crop  = @group.crop
    day = 86400
    seed_date = @group.seed_date
    propagation_date = @group.propagation_date
    production_date = @group.production_date
    harvest_date = @group.harvest_date
    readings = @group.readings
    tasks = @group.tasks.sort_by{|task| task.due}

    city = @group.location.split(', ')[0].split(' ').join('_')
    state = @group.location.split(', ')[1]
    today = Time.now
    result = {'maxhumidity': [], 'minhumidity': [], 'maxtempf': [], 'mintempf': [], 'meantempf': []}

    until seed_date.strftime("%Y/%m/%d") == today.strftime("%Y/%m/%d")

      search_date = seed_date.year.to_s + (sprintf '%02d', seed_date.month).to_s + (sprintf '%02d', seed_date.day).to_s
      history = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/history_#{search_date}/q/#{state}/#{city}.json")
      dailysummary = JSON.parse(history.body)['history']['dailysummary'][0]
      result[:maxtempf] << dailysummary['maxtempi']
      result[:mintempf] << dailysummary['mintempi']
      result[:meantempf] << dailysummary['meantempi']
      result[:maxhumidity] << dailysummary['maxhumidity']
      result[:minhumidity] << dailysummary['minhumidity']
      seed_date += day

    end

      hourly = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/hourly/q/#{state}/#{city}.json")
      today_tempf = JSON.parse(hourly.body)['hourly_forecast'].map{|m| m['temp']['english']}
      today_humidity = JSON.parse(hourly.body)['hourly_forecast'].map{|m| m['humidity']}
      today_hours = JSON.parse(hourly.body)['hourly_forecast'].map{|m| m['FCTTIME']['hour']}
      result[:today_tempf] = today_tempf
      result[:today_humidity] = today_humidity
      result[:today_hours] = today_hours


      current = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/conditions/q/#{state}/#{city}.json")
      current_temp = JSON.parse(current.body)['current_observation']['temp_f']
      current_humidity = JSON.parse(current.body)['current_observation']['relative_humidity']
      current_time = JSON.parse(current.body)['current_observation']['observation_time_rfc822'].split(' ')[4]
      result[:current_time] = current_time
      result[:current_temp] = current_temp
      result[:current_humidity] = current_humidity.split('%')[0..-1].join('')

      astronomy = Excon.get("http://api.wunderground.com/api/49d0e7851426e4b9/astronomy/q/#{state}/#{city}.json")
      sunrise = JSON.parse(astronomy.body)['moon_phase']['sunrise']['hour'].to_i
      sunset = JSON.parse(astronomy.body)['moon_phase']['sunset']['hour'].to_i
      sun_hours = sunset - sunrise
      result[:sunset] = sunset
      result[:sunrise] = sunrise
      result[:sun_hours] = sun_hours

      today = Time.now.strftime("%Y/%m/%d").gsub!("/","-")
      yesterday = (Time.now - 86400).strftime("%Y/%m/%d").gsub!("/","-")

      history = Excon.get("https://api.weatherbit.io/v2.0/history/daily?city=#{city},#{state}&start_date=#{yesterday}&end_date=#{today}&key=c5ff710c64cd4b1ea8016f272abd120e", :persistent => true)
      summary = JSON.parse(history.body)
      average_direct_normal_solar_irradiance = summary['data'][0]['dni']
      footcandles = average_direct_normal_solar_irradiance / 0.101
      # micromol_per_sqm_per_sec = footcandles * 0.02
      # micromol_per_sqm_per_day = micromol_per_sqm_per_sec * 3600 * sun_hours
      moles_per_day = (footcandles * 0.00071 * sun_hours).round(0)
      result[:dli] = moles_per_day
      result[:status] = status_check(seed_date, propagation_date, production_date, harvest_date)
      result[:readings] = readings
      result[:tasks] = tasks



      return render json: {data: result, crop: @crop, group: @group}
  end

  # private
  #
  # def group_params
  #   params.require(:group).permit(:user_id, :crop_id, :seed_date, :harvest_date, :germination_days, :propagation_days, :production_days, :expected_harvest_lbs, :actual_harvest_lbs, :harvested)
  # end


end
