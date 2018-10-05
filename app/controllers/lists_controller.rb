class ListsController < ApplicationController
  def index
    @lists = current_user.lists.order(id: :desc)
    render json: { lists: @lists.to_json(include: :tasks) }
  end

  def export
    respond_to do |format|
      format.html
      format.csv { send_data current_user.lists.to_csv, filename: "lists-#{current_user.name}-#{Date.today}.csv" }
      format.pdf do
        pdf = ListsPdf.new(current_user)
        send_data pdf.render, filename: "lists-#{current_user.name}-#{Date.today}.pdf", type: 'application/pdf'
      end
    end
  end

  def create
    @list = current_user.lists.create(list_params)
    if @list.save
      render json: { list: @list }
    else
      render json: { errors: @list.errors }
    end
  end

  def update
    @list = List.find(params[:id])
    @list.name = params[:list][:name]
    @list.description = params[:list][:description]
    if @list.save
      render json: { list: @list }
    else
      render json: { error: @list.errors }
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.tasks.map(&:destroy)
    if @list.destroy
      render json: { list: @list }
    else
      render json: { error: @list.errors }
    end
  end

  private

  def list_params
    params.require(:list)
    params.permit(:id, :name, :description)
  end

end
