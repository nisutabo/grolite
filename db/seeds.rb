
require 'faker'

day = 86400
today = Time.now
location = 'New York, NY'

@user = User.create(username: 'one', password: '1', location: 'New York, NY')


@strawberry =  Crop.create(name: 'Strawberry (June-Bearing)', scientific_name: 'Fragaria Ananassa', crop_group: 'Fruit', temp_day: 75, temp_day_min: 68, temp_night: 59, temp_night_min: 50, maxhumidity: 75, minhumidity: 65, ec: 1.5, ph: 5.8, sun_hours: 12, dli: 28, dli_min: 20, dth: 105, market_value: 2)

  10.times do
    number = Faker::Number.between(1,7)
    seed_date = today - (day * number)
    germination_days = 21
    propagation_days = 42
    production_days = 42
    propagation_date = seed_date + (day * germination_days)
    production_date = propagation_date + (day * propagation_days)
    harvest_date = production_date + (day * production_days)
    expected_harvest_lbs = Faker::Number.between(100, 200)
    harvested = false
    trays = 200
    crop_id = @strawberry.id
    crop_name = @strawberry.name
    crop_group = @strawberry.crop_group
    scientific_name = @strawberry.scientific_name
    @group = Group.create(seed_date: seed_date, propagation_date: propagation_date, production_date: production_date, harvest_date: harvest_date, germination_days: germination_days, propagation_days: propagation_days, production_days: production_days, expected_harvest_lbs: expected_harvest_lbs, harvested: harvested, crop_id: crop_id, location: @user.location, crop_name: crop_name, crop_group: crop_group, scientific_name: scientific_name, trays: trays, user_id: 1)
        i = day
        ((today - seed_date)/day).round(0).times do
        a = Faker::Number.between(1,4)
        b = Faker::Number.decimal(0,1).to_f
        ec = a + b
        c = Faker::Number.between(2,7)
        d = Faker::Number.decimal(0,1).to_f
        ph = c + d
        date = seed_date + i
        Reading.create(group_id: @group.id, ph: ph, ec: ec, date: date )
        i += 86400
      end

      random_day = (day * 9)
      Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Collect pH/EC readings')
      Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Scan group for any signs of disease')
      Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Scan group for any signs of pests')
      Task.create(group_id: @group.id, crop_id: crop_id, due: (seed_date + random_day), content: 'Apply M-PEDE based on Integrated Pest Management guidelines')
      Task.create(group_id: @group.id, crop_id: crop_id, due: propagation_date, content: 'Move trays to propagation zone')
      Task.create(group_id: @group.id, crop_id: crop_id, due: propagation_date, content: 'Collect pH/EC readings')
      Task.create(group_id: @group.id, crop_id: crop_id, due: (propagation_date + random_day), content: 'Mix nutrients')
      Task.create(group_id: @group.id, crop_id: crop_id, due: (production_date), content: 'Move trays to production zone')
      Task.create(group_id: @group.id, crop_id: crop_id, due: production_date, content: 'Collect pH/EC readings')
      Task.create(group_id: @group.id, crop_id: crop_id, due: harvest_date, content: 'Harvest Group')

  end


@basil = Crop.create(name: 'Basil (Genovese)', scientific_name: 'Ocimum Basilicum', crop_group: 'Herb', temp_day: 80, temp_day_min: 60, temp_night: 65, temp_night_min: 52, maxhumidity: 65, minhumidity: 40, ec: 1.5, ph: 6.5, sun_hours: 8, dli: 16, dli_min: 10, dth: 40, market_value: 4)
  5.times do
    number = Faker::Number.between(1,40)
    seed_date = today - (day * number)
    germination_days = 10
    propagation_days = 15
    production_days = 15
    propagation_date = seed_date + (day * germination_days)
    production_date = propagation_date + (day * propagation_days)
    harvest_date = production_date + (day * production_days)
    expected_harvest_lbs = Faker::Number.between(40, 80)
    harvested = false
    trays = 100
    crop_id = @basil.id
    crop_name = @basil.name
    crop_group = @basil.crop_group
    scientific_name = @basil.scientific_name
    @group = Group.create(seed_date: seed_date, propagation_date: propagation_date, production_date: production_date, harvest_date: harvest_date, germination_days: germination_days, propagation_days: propagation_days, production_days: production_days, expected_harvest_lbs: expected_harvest_lbs, harvested: harvested, crop_id: crop_id, location: @user.location, crop_name: crop_name, crop_group: crop_group, scientific_name: scientific_name, trays: trays, user_id: 1)
      i = day
      ((today - seed_date)/day).round(0).times do
      a = Faker::Number.between(1,3)
      b = Faker::Number.decimal(0,1).to_f
      ec = a + b
      c = Faker::Number.between(4,6)
      d = Faker::Number.decimal(0,1).to_f
      ph = c + d
      date = seed_date + i
      Reading.create(group_id: @group.id, ph: ph, ec: ec, date: date )
      i += 86400
    end

    random_day = (day * 9)
    Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Collect pH/EC readings')
    Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Scan group for any signs of disease')
    Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Scan group for any signs of pests')
    Task.create(group_id: @group.id, crop_id: crop_id, due: (seed_date + random_day), content: 'Apply M-PEDE based on Integrated Pest Management guidelines')
    Task.create(group_id: @group.id, crop_id: crop_id, due: propagation_date, content: 'Move trays to propagation zone')
    Task.create(group_id: @group.id, crop_id: crop_id, due: propagation_date, content: 'Collect pH/EC readings')
    Task.create(group_id: @group.id, crop_id: crop_id, due: (propagation_date + random_day), content: 'Mix nutrients')
    Task.create(group_id: @group.id, crop_id: crop_id, due: (production_date), content: 'Move trays to production zone')
    Task.create(group_id: @group.id, crop_id: crop_id, due: production_date, content: 'Collect pH/EC readings')
    Task.create(group_id: @group.id, crop_id: crop_id, due: harvest_date, content: 'Harvest Group')

  end


@cherry_tomato = Crop.create(name: 'Cherry Tomato', scientific_name: 'Solanum Lycopersicum', crop_group: 'Fruit', temp_day: 85, temp_day_min: 70, temp_night: 68, temp_night_min: 59, maxhumidity: 80, minhumidity: 65, ec: 3.0, ph: 6.0, sun_hours: 12, dli: 30, dli_min: 20, dth: 70, market_value: 3)
  5.times do
    number = Faker::Number.between(1,7)
    seed_date = today - (day * number)
    germination_days = 10
    propagation_days = 30
    production_days = 30
    propagation_date = seed_date + (day * germination_days)
    production_date = propagation_date + (day * propagation_days)
    harvest_date = production_date + (day * production_days)
    expected_harvest_lbs = Faker::Number.between(100, 200)
    harvested = false
    trays = 100
    crop_id = @cherry_tomato.id
    crop_name = @cherry_tomato.name
    crop_group = @cherry_tomato.crop_group
    scientific_name = @cherry_tomato.scientific_name
    @group = Group.create(seed_date: seed_date, propagation_date: propagation_date, production_date: production_date, harvest_date: harvest_date, germination_days: germination_days, propagation_days: propagation_days, production_days: production_days, expected_harvest_lbs: expected_harvest_lbs, harvested: harvested, crop_id: crop_id, location: @user.location, crop_name: crop_name, crop_group: crop_group, scientific_name: scientific_name, trays: trays, user_id: 1)
      i = day
      ((today - seed_date)/day).round(0).times do
      a = Faker::Number.between(1,3)
      b = Faker::Number.decimal(0,1).to_f
      ec = a + b
      c = Faker::Number.between(4,6)
      d = Faker::Number.decimal(0,1).to_f
      ph = c + d
      date = seed_date + i
      Reading.create(group_id: @group.id, ph: ph, ec: ec, date: date )
      i += 86400
    end

    random_day = (day * 9)
    Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Collect pH/EC readings')
    Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Scan group for any signs of disease')
    Task.create(group_id: @group.id, crop_id: crop_id, due: seed_date, content: 'Scan group for any signs of pests')
    Task.create(group_id: @group.id, crop_id: crop_id, due: (seed_date + random_day), content: 'Apply M-PEDE based on Integrated Pest Management guidelines')
    Task.create(group_id: @group.id, crop_id: crop_id, due: propagation_date, content: 'Move trays to propagation zone')
    Task.create(group_id: @group.id, crop_id: crop_id, due: propagation_date, content: 'Collect pH/EC readings')
    Task.create(group_id: @group.id, crop_id: crop_id, due: (propagation_date + random_day), content: 'Mix nutrients')
    Task.create(group_id: @group.id, crop_id: crop_id, due: (production_date), content: 'Move trays to production zone')
    Task.create(group_id: @group.id, crop_id: crop_id, due: production_date, content: 'Collect pH/EC readings')
    Task.create(group_id: @group.id, crop_id: crop_id, due: harvest_date, content: 'Harvest Group')

  end
