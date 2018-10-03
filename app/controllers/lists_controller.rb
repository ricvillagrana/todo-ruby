class ListsController < ApplicationController
  def index
    @lists = current_user.lists.order(id: :desc)
    render json: { lists: @lists.to_json(include: :tasks) }
  end

  def create
    @list = current_user.lists.create(list_params)
    if @list.save
      render json: { list: @list }
    else
      render json: { errors: @list.errors }
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.tasks.map {|task| task.destroy}
    if @list.destroy
      render json: { list: @list }
    else
      render json: { error: @list.errors }
    end
  end

  private

  def list_params
    params.require(:list)
    params.permit(:name, :description)
  end

end
