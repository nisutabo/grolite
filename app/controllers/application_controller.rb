class ApplicationController < ActionController::API

  def status_check(seed_date, propagation_date, production_date, harvest_date)
    result = []
    day = 86400

    today = Time.now

    if today < propagation_date
      result << 'GERMINATION'
      result << (propagation_date - today) / day
    elsif ((today >= propagation_date) && (today < production_date))
      result << 'PROPAGATION'
      result << (production_date - propagation_date) / day
    elsif ((today >= production_date) && (today < harvest_date))
      result << 'PRODUCTION'
      result << (harvest_date - production_date) / day
    else
      result << 'DUE FOR HARVEST'
    end

    result[1] = result[1].round(0) if result.length > 1
    return result
  end

  def issue_token(payload)
    JWT.encode(payload, 'basilparty')
  end

  def decode_token
    JWT.decode(get_token, 'basilparty')[0]
  end

  def this_user
    decoded_hash = decode_token
    User.find(decoded_hash['user_id'])
  end

  def get_token
    request.headers["Authorization"]
  end

end
