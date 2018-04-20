class Api::V1::AuthController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    @groups = @user.groups
    @totalvalue = @groups.map{|g| g.crop.market_value * g.expected_harvest_lbs}.inject(:+)
    @crops = Crop.all
    if @user && @user.authenticate(params[:password])
      jwt = issue_token({user_id: @user.id})
      render json: {user: @user, jwt: jwt, groups: @groups, crops: @crops, total_value: @totalvalue}
    else
      render json: {error: "Authentication Failed"}
    end
  end

  def show
    @groups = this_user.groups
    @totalvalue = @groups.map{|g| g.crop.market_value * g.expected_harvest_lbs}.inject(:+)
    @crops = Crop.all
    if this_user
      render json: {user: this_user, groups: @groups, crops: @crops, total_value: @totalvalue}
    else
      render json: {error: "Authentication Failed"}
    end
  end
end
