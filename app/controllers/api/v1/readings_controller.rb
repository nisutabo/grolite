class Api::V1::ReadingsController < ApplicationController


  def index
    @readings = Reading.all
    render json: @readings
  end

  def show
    @reading = Reading.find(params[:id])
    return render json: @reading
  end

  def create
    time = Time.now
    @reading = Reading.new(user_id: params[:user_id], group_id: params[:group_id], ph: params[:ph], ec: params[:ec], date: time)
    if @reading.save
      return render json: @reading
    else
      return render json: {errors: @reading.errors.full_messages}, status: 422
    end
  end

  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy
    @readings = Reading.all
    render json: @readings
  end


end
