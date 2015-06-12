class Admin::PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user 
  
  def index
    @positions = Position.all 
    @positions = @positions.paginate page: params[:page], per_page: Settings.index.page
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:info] = "Created new position: #{@position.name}"
      redirect_to admin_position_path(@position)
    else
      render :new
    end
  end

  def show
    @position = Position.find params[:id]
  end

  def edit
    @position = Position.find params[:id]
  end

    def update
    @position = Position.find params[:id]
    if @position.update(position_params)
      flash[:info] = "Updated Position!"
      redirect_to admin_position_path(@position)
    else
      render :edit
    end
  end

  def destroy
    Position.find(params[:id]).destroy
    flash[:success] = "Deleted position."
    redirect_to admin_positions_path
  end


  private
  def position_params
    params.require(:position).permit :name, :abbreviation
  end
end
