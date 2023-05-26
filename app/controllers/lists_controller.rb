class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      # No need for app/views/lists/create.html.erb
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    # No need for app/views/lists/destroy.html.erb
    redirect_to lists_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:comment, :references.movie, :references.list)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
