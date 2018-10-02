class ListsController < ApplicationController
  def create
    @list = current_user.lists.create(list_params)
    if @list.save
      render json: { list: @list }
    else
      render json: { errors: @list.errors }
    end
  end

  def index
    @lists = current_user.lists
    render json: { lists: @lists.to_json(include: :tasks) }
  end

  private

  def list_params
    params.require(:list)
    params.permit(:name, :description)
  end

end
