class Api::V1::TasksController < ApplicationController

  def index
    @tasks = Task.all
    @tasks = @tasks.sort_by{|task| task.id}
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    return render json: @task
  end

  def create

    @task = Task.new(group_id: params[:group_id], crop_id: params[:crop_id], due: params[:due], content: params[:content])
    if @task.save
      return render json: @task
    else
      return render json: {errors: @task.errors.full_messages}, status: 422
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(done: params[:done])
    return render json: @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @tasks = Task.all.sort_by{|task| task.id}
    render json: @tasks
  end

end
