class TasksController < ApplicationController

  def index
    render json: { tasks: current_user.tasks }
  end

  def create
    list = List.find(params[:list_id])
    @task = list.tasks.create(task_params)
    if @task.save
      render json: { task: @task }
    else
      render json: { error: @task.errors }
    end
  end

  private

  def tasks_params
    params.require(:task)
    params.permit(:name, :done, :list_id)
  end
end
