class Api::V1::CropsController < ApplicationController

  def index
    @crops = Crop.all
    render json: @crops
  end

  def show
    @crop = Crop.find(params[:id])
    return render json: @crop
  end



  def create
    @crop = Crop.new(crop_params)
    if @crop.save
      return render json: @crop
    else
      return render json: {errors: @crop.errors.full_messages}, status: 422
    end
  end

  def update
    @crop = Crop.find(params[:id])

    @crop.update(crop_params)
    if @crop.save
      render json: @crop
    else
      render json: {errors: @account.errors.full_messages}, status: 422
    end
  end

  def destroy
    @crop = Crop.find(params[:id])
    @crop.destroy
    @crops = Croup.all
    render json: @crops
  end


  private

  def crop_params
    params.require(:crop).permit(:scientific_name, :crop_group, :temp_day, :temp_night, :humidity, :ph,
    :ec, :dli, :sun_hours, :dth)
  end
end
