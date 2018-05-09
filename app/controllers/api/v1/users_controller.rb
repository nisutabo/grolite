class Api::V1::UsersController < ApplicationController


  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(username: params[:username], password: params[:password], location: params[:location])
    @groups = @user.groups
    @totalvalue = @groups.map{|g| g.crop.market_value * g.expected_harvest_lbs}.inject(:+)
    @crops = Crop.all
    if @user.save
      jwt = issue_token({user_id: @user.id})
      render json: {user: @user, jwt: jwt, groups: @groups, crops: @crops, total_value: @totalvalue}
    end
  end

  def groups
    @user = User.find(params[:id])
    @groups = @user.groups
    @totalvalue = @groups.map{|g| g.crop.market_value * g.expected_harvest_lbs}.inject(:+)
    @crops = Crop.all
    render json: {groups: @groups, crops: @crops, total_value: @totalvalue}
  end


end
