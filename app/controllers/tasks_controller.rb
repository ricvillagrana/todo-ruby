class TasksController < ApplicationController

  def index
    render json: { tasks: current_user.tasks.order_by(id: :asc) }
  end

  def create
    list = List.find(params[:list_id])
    @task = list.tasks.create(tasks_params)
    if @task.save
      render json: { task: @task }
    else
      render json: { error: @task.errors }
    end
  end

  def export_csv
    respond_to do |format|
      format.html
      format.csv { send_data current_user.tasks.to_csv, filename: "tasks-#{current_user.name}-#{Date.today}.csv" }
    end
  end

  def export_csv_from_list
    list = current_user.lists.find(params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data list.tasks.to_csv, filename: "tasks-#{current_user.name}-#{list.name}-#{Date.today}.csv" }
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.done = params[:task][:done]
    @task.name = params[:task][:name]
    if @task.save
      render json: { task: @task }
    else
      render json: { error: @task.errors }
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render json: { task: @task }
    else
      render json: { error: @task.errors }
    end
  end

  private

  def tasks_params
    params.require(:task)
    params.permit(:id, :name, :done, :list_id)
  end
end
