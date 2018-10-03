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
